class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  require GorgEngine::Engine.config.root + 'app' + 'controllers' + self.name.underscore
end
