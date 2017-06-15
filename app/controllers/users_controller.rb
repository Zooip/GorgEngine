class UsersController < ::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :sync_with_gram]
  #autocomplete :users, :hruid , :full => true, :display_value =>:hruid, extra_data: [:id, :firstname ] #, :scopes => [:search_by_name]


  # GET /users
  # GET /users.json
  def index
    @query= params[:query]
    @users = User.accessible_by(current_ability).search(@query).paginate(:page => params[:page])
    authorize! :update, @users
    respond_to do |format|
      format.html do
        if @users.count==1
          return redirect_to(user_path(@users.first.id))
        end
      end
      format.json
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize! :read, @user
  end

  # GET /users/new
  def new
    @user = User.new
    authorize! :create, @user
    @roles=Role.accessible_by(current_ability)
  end

  # GET /users/1/edit
  def edit
    authorize! :update, @user
    @roles=Role.accessible_by(current_ability)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize! :create, @user
    authorize! :update, (user_params[:role_id].present? ? Role.find(user_params[:role_id]) : Role)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: I18n.translate('users.flash.create.success', users: @user.fullname) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, notice: I18n.translate('users.flash.create.fail') , status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize! :update, @user
    authorize! :update, (user_params[:role_id].present? ? Role.find(user_params[:role_id]) : Role)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: I18n.translate('users.flash.update.success', users: @user.fullname) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, notice: I18n.translate('users.flash.update.fail', users: @user.fullname) , status: :unprocessable_entity}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :destroy, @user
    username=@user.fullname
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice:  I18n.translate('users.flash.destroy.success', users: username) }
      format.json { head :no_content }
    end
  end

  def sync_with_gram
    authorize! :sync, @user
    respond_to do |format|
      if @user.syncable? && ( @user.next_sync_allowed_at <= Time.now)
        if @user.update_from_gram
          format.html { redirect_to @user, notice: I18n.translate('users.flash.sync.success', users: @user.fullname) }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { redirect_to @user, notice: I18n.translate('users.flash.sync.fail', users: @user.fullname)}
          format.json { render json: '{"error": "Problems occured during syncronization"}', status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @user, notice: I18n.translate('users.flash.sync.too_soon', users: @user.fullname, eta: (@user.next_sync_allowed_at-Time.now).round)}
        format.json { render json: "{\"error\": \"Try again in #{(@user.next_sync_allowed_at-Time.now).round} seconds\"}", status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user =(params[:id] ?  User.find_by_id_or_hruid_or_uuid(params[:id]) : current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :hruid, :id, :role_id, :password, :password_confirmation)
  end
end