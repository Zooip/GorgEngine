# GorgEngine

This project rocks and uses MIT-LICENSE.


# How to use GorgEngine
## UI layout
Add this line to use gorg_engine layout :
```ruby
class ApplicationController < ActionController::Base
  layout 'gorg_engine/application'
end
```

## Authorisations
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

#Menu
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

# Todo
* put migration template in initializer