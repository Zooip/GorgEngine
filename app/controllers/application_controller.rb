class ApplicationController < ::ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'gorg_engine/application'

  before_action :masquerade_user!

  # Share all helpers
  helper GorgEngine::Engine.helpers
  helper :all

end
