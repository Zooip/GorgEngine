# GorgEngine
[![Build Status](https://travis-ci.org/gadzorg/GorgEngine.svg?branch=master)](https://travis-ci.org/gadzorg/GorgEngine)
[![Gem Version](https://badge.fury.io/rb/gorg_engine.svg)](https://badge.fury.io/rb/gorg_engine)
[![Gem Version](https://codeclimate.com/github/gadzorg/GorgEngine.png)](https://codeclimate.com/github/gadzorg/GorgEngine)

This project rocks and uses MIT-LICENSE.


# How to use GorgEngine

## Install
For Rails >= 5.0, please use 2.x versions (currently only available on GitHub).

```ruby
gem "gorg_engine", git: "https://github.com/gadzorg/GorgEngine", ref: "v2.0.1"
```

For Rails 4.x, use 1.x version like usual

```ruby
gem "gorg_engine", "< 2"
```

## Routes
Add in your routes file :
```ruby
  mount GorgEngine::Engine => "gorg_engine"
```
## UI layout
Add this line to use gorg_engine layout :
```ruby
class ApplicationController < ActionController::Base
  layout 'gorg_engine/application'
end
```

## Authorizations
Cancan is used for authorisation.
You have to run :
```ruby
rails g cancan:ability
```

## Extend GorgEngine controllers
GorgEngine provide some base controller :
* ApplicationController
* UserController

To extend one of these controller in your app, add this line in your app controller file :  
`  require GorgEngine::Engine.config.root + 'app' + 'controllers' + self.name.underscore
`

For exemple, in your application controller :
```ruby
class ApplicationController < ActionController::Base

  require GorgEngine::Engine.config.root + 'app' + 'controllers' + self.name.underscore
  
  def my_method
    #cool stuff
  end
end
```

#Gram v2 API client
You have to setup an [initializer](https://github.com/gadzorg/gram2_api_client_ruby#setup) to configure Gram API client

#Navbar
##Logo
You can customize you app logo. Create `config/initializers/menu.rb` and add :
```ruby
# config/initializers/menu.rb
APP_LOGO_PATH = "insert url here"
```
You can use asset path like `asset_subfolder/logo.png` or external url.
##Menu
You have to configure you app menu.

Some link must be hidden according abilities. `ability_action` and `ability_object` are used for Cancancan. In the example bellow, il generate the following condition `can ? :read, :user`. 

You can use `url` or `path` for your menu link.

The last item, generate the default admin menu.
```yaml
# config/menu.yml
 -
   name: my_awesome_menu_title
   title: My awesome menu title
   ability_action: read
   ability_object: user
   url: '#'
   path: 'user_path'
   login_required: true # hide this link for non-logged users
   dropdown: false # if this menu is a drop down menu

 -
   name: google
   title: Google
   ability_action: read
   ability_object: user
   url: 'http://google.com'
   login_required: false
   dropdown: false
   
 -  # Drop down admin menu
    name: administration
    title: Administration
    ability_action: read
    ability_object: admin
    login_required: true
    dropdown: true
    items:
      - # Title. if you dont set `url` or `path` a title is generated 
        name: general
        title: Général
        ability_action: read
        ability_object: admin
      -
        name: configuration
        title: Configuration
        ability_action: read
        ability_object: admin
        path: 'admin_configurable_path'
        login_required: true
        dropdown: false
      -
        name: utilisateurs
        title: Utilisateurs
        ability_action: read
        ability_object: user
        path: 'users_path'
        login_required: true
        dropdown: false
      -
        name: roles
        title: Roles
        ability_action: read
        ability_object: role
        path: 'roles_path'
        login_required: true
        dropdown: false
```

## Database migration
You have to generate a migration template AND to edit it BEFORE running migration. 
```bash
rails g gorg_engine:install
```

Edition : 
You HAVE TO edit this `db/migrations/xxxxxxx_init_gorg_engine.rb` file to avoid conflict with your current migrations
For each table and for each column : check if exist in your current project, and comment the line if needed.


## Customization
### 403 Page
Overload this method in your application controller and add your 403 page in `public/403.html`
```ruby
  def access_denied(_exception)
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html {
        store_location_for :user, request.fullpath
        if user_signed_in?
          render :file => "#{Rails.root}/public/403.html", :status => 403
        else
          redirect_to new_user_session_path
        end
      }
    end
  end
```