module GorgEngine
  class Engine < ::Rails::Engine

    require 'haml-rails'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'unobtrusive_flash'
    require 'materialize-sass'
    require 'uglifier'
    require 'devise'
    require 'omniauth'
    require 'omniauth-cas'
    require 'devise_masquerade'
    require 'cancancan'
    require 'will_paginate'
    require 'will_paginate/active_record'
    require 'awesome_print'
    require 'gorg_slack_chat'
    require 'simple_form'
    require 'virtus'
    require 'gram_v2_client'

    config.generators do |g|
      g.template_engine :haml
    end

    #Load all controllers by default
    config.eager_load_paths << File.expand_path("../app", __FILE__)

    # Load helpers to the app
    require GorgEngine::Engine.config.root + 'app' + 'helpers' + 'application_helper'

    # config assets
    initializer :assets do |config|
      Rails.application.config.assets.paths << GorgEngine::Engine.root.join("app", "assets", "images", "gorg_engine")
      Rails.application.config.assets.precompile += %w( gorg_engine/logo_alumni.jpg )
      Rails.application.config.assets.precompile += %w( gorg_engine/gorg.scss )
    end

    require File.expand_path('config/extra_config.rb',GorgEngine::Engine.root)




  end
end
