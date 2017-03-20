module GorgEngine
  class Engine < ::Rails::Engine

    require 'haml-rails'
    require 'jquery-ui-rails'
    require 'materialize-sass'
    require 'uglifier'

    config.generators do |g|
      g.template_engine :haml
    end
  end
end
