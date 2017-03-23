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

The last item, `admin-menu`, generate the default admin menu.
```yaml
# config/menu.yml
 my_awesome_menu_title:
   name: "My awesome menu title"
   ability_action: read
   ability_object: user
   url: '#'
   path: 'user_path'
   login_required: true # hide this link for non-logged users
   dropdown: false # if this menu is a drop down menu

 google_menu:
   name: "Google"
   ability_action: read
   ability_object: user
   url: 'http://google.com'
   login_required: false
   dropdown: false
   
  admin-menu:
    name: Administration
    ability_action: read
    ability_object: admin
    login_required: true
    dropdown: true
    items:
      sub_menu_general_title:
        name: Général
        ability_action: read
        ability_object: admin
      sub_menu_config:
        name: Configuration
        ability_action: read
        ability_object: admin
        path: 'admin_configurable_path'
        login_required: true
        dropdown: false
      sub_menu_users:
        name: Utilisateurs
        ability_action: read
        ability_object: user
        path: 'users_path'
        login_required: true
        dropdown: false
      sub_menu_roles:
        name: Roles
        ability_action: read
        ability_object: role
        path: 'roles_path'
        login_required: true
        dropdown: false  

```

# Todo
* put migration template in initializer