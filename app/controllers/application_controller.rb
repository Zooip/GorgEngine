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



  def redirect_if_maintenance_mode
    if check_maintenance_mode && controller_name != 'devise/sessions' && controller_name != 'static_page' && !current_user.nil?
      unless current_user.has_role?(:admin)  || current_user.has_role?(:support) || Configurable[:allowed_uuid_in_maintenance_mode].split.include?(current_user.uuid)
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
end
