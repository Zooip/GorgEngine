module GorgEngine
  class Engine < ::Rails::Engine

    require 'haml-rails'
    require 'jquery-ui-rails'
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

    config.generators do |g|
      g.template_engine :haml
    end

    config.eager_load_paths << File.expand_path("../app", __FILE__)


  end
end
