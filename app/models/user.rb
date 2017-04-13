class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable,
         :trackable,
         :masqueradable,
         :omniauthable,
         :omniauth_providers => [:GadzOrg]

  ##
  # synced_with_gram : True if last sync with gram data succeed (false if not).
  # false if object never tried to sync at runtime. Auto sync performed at connection via CAS
  attr_accessor :synced_with_gram

  # Associations
  belongs_to :role


  after_initialize :set_default_values

  validates :hruid, uniqueness: true, presence: true


  ############################################################################
  #######  TEMPLATE FUNCTIONS  ###############################################
  ############################################################################
  ##
  # Check current role
  def has_role? (role_name)
    self.role ? self.role.name==(role_name.to_s) : false
  end


  ##
  # Add or change role
  def  add_role (role_name)
    self.update_attribute(:role_id,Role.find_or_create_by(name: role_name).id)
  end

  ##
  # Delete current role if any
  def  remove_role (role_name=nil)
    self.update_attribute(:role_id,nil) unless !self.role ||(role_name && role_name.to_s != self.role.name)
  end

  ##
  # Update local users data with data contained in GrAM
  def update_from_gram
    self.synced_with_gram = false
    if self.syncable?
      begin
        gram_data= GramV2Client::Account.find(self.uuid)
        self.email=gram_data.email
        self.firstname=gram_data.firstname
        self.lastname=gram_data.lastname
        self.last_gram_sync_at = Time.now
        self.hruid = gram_data.hruid
        self.is_gadz = gram_data.is_gadz
        self.avatar_url = gram_data.avatar_url
        if self.save
          self.synced_with_gram = true
          return self
        else
          return false
        end
      rescue ActiveResource::ResourceNotFound
        logger.error "[GrAM] Utilisateur introuvable : hruid = #{self.hruid} uuid = #{self.uuid}"
        return false
      rescue ActiveResource::ServerError
        logger.error "[GrAM] Connexion au serveur impossible"
        return false
      rescue ActiveResource::UnauthorizedAccess, ActiveResource::ForbiddenAccess
        logger.error "[GrAM] Connexion au serveur impossible : verifier identifiants"
        return false
      end
    else
      return false
    end

  end

  def syncable?
    uuid.present?
  end

  def next_sync_allowed_at
    self.last_gram_sync_at ? self.last_gram_sync_at + 5.minutes : Time.now
  end

  ##
  # Return an User to login after Omniauth authentification. This users is retrieve in database with hruid or
  # created on the fly from CAS data
  def self.omniauth(auth_data, signed_in_resource=nil)

    logger.debug "=================================="
    logger.debug "Connexion depuis le CAS uid : "+auth_data[:uid]
    logger.debug "Infos de connection :"
    logger.debug auth_data.inspect

    return nil unless auth_data[:extra][:uuid]

    # auth_data : take a look on Users::OmniauthCallbacksController
    unless user = User.find_by_uuid(auth_data[:extra][:uuid])
      user = User.new(
          email: auth_data[:info][:email],
          password: Devise.friendly_token[0,20],
          hruid: auth_data[:uid],
          firstname: auth_data[:extra][:firstname],
          lastname: auth_data[:extra][:lastname],
          uuid: auth_data[:extra][:uuid],
      )
      user.save
    end

    if user.persisted?
      user.update_from_gram
      user
    else
      logger.error "Donnees renvoyes par le CAS invalide : "+auth_data.to_s+" ---- "+user.errors.messages.inspect
      nil
    end
  end

  ##
  # Return users firstname and lastname
  def fullname
    firstname + " " + lastname
  end


  def self.find_by_id_or_hruid_or_uuid(id)
    find_by(id: id) || find_by(uuid: id) || find_by(hruid: id)
  end

  def is_gadz?
    self.update_attribute( :is_gadz, GramV2Client::Account.find(self.uuid).is_gadz)
    self.is_gadz
  end

  def self.search(query)
    sql_query= nil
    if query
      sql_query=<<END_SQL
LOWER(users.firstname) LIKE :like_query
OR LOWER(users.lastname) LIKE :like_query
OR LOWER(CONCAT(users.firstname,' ',users.lastname)) LIKE :like_query
OR LOWER(users.hruid) LIKE :like_query
OR LOWER(users.uuid) = :query
OR LOWER(email_redirect_accounts.redirect) = :query
END_SQL
    end

    self.where(sql_query,query: query.to_s.downcase,like_query: "%#{query.to_s.downcase}%")
  end


  private

  ############################################################################
  #######  TEMPLATE FUNCTIONS  ###############################################
  ############################################################################

    ##
    #Define default values of runtime attributes
    def set_default_values
      self.synced_with_gram = false
    end
end
