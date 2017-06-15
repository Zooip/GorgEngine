class ApplicationController < ::ActionController::Base
  # Add configurable engine
  include ConfigurableEngine::ConfigurablesController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'gorg_engine/application'

  # Add maintenance mode redirection
  before_filter :redirect_if_maintenance_mode

  before_action :masquerade_user!

  # Share all helpers
  helper GorgEngine::Engine.helpers
  helper :all

  rescue_from CanCan::AccessDenied, with: :access_denied



  def redirect_if_maintenance_mode
    if check_maintenance_mode &&
        controller_name != 'devise/sessions' &&
        controller_name != 'static_page' &&
        !current_user.nil?
      unless current_user.has_role?(:admin)  ||
          current_user.has_role?(:support) ||
          Configurable[:allowed_uuid_in_maintenance_mode].split.include?(current_user.uuid)
        cookies.delete(:secureusertokens)
        reset_session
        redirect_to root_path
      end
    end
  end

  def check_maintenance_mode
    # caching maintenance state
    Rails.cache.fetch("maintenance_mode", expires_in: 1.minute){ Configurable[:maintenance_mode] }
  end

  private
  def access_denied(_exception)
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html {
        store_location_for :user, request.fullpath
        if user_signed_in?
          render :file => "#{GorgEngine::Engine.root}/public/403.html", :status => 403
        else
          redirect_to new_user_session_path
        end
      }
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    Rails.application.secrets.cas_provider_url ? URI::HTTPS.build(host: Rails.application.secrets.cas_provider_host, path:"/cas/logout", query: "service=#{root_url}").to_s : root_url
  end
end
