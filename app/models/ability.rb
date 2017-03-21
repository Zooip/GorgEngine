class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in users here. For example:
    #
    #   users ||= User.new # guest users (not logged in)
    #   if users.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the users
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the users can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the users can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest users (not logged in)
    #if users.has_role? :admin
      can :manage, :all
     # can :manage, Role
      #can :masquerade, User
      #cannot :masquerade, User, :role_id => Role.where(name: ["admin","support"]).pluck(:id)
    #elsif users.has_role? :support
     # can :read, :admin
      #can :manage, User
      #can :masquerade, User
      #TODO: uncomment when adding roles
      #cannot [:update, :destroy, :create], User, :role_id => Role.where(name: ["admin"]).pluck(:id)
      # cannot :masquerade, User, :role_id => Role.where(name: ["admin","support"]).pluck(:id)
      # can :manage, Role
      # cannot :manage, Role, :name => 'admin'
      # can :read, Role
    #end

    if user.persisted?
      #can [:read], User, :id => users.id if users.is_gadz_cached?
    end

  end
end




