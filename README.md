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

# Todo
* put migration template in initializer