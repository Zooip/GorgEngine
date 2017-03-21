Rails.application.routes.draw do
  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
      #:sessions => "users/sessions",
      masquerades: "admin/masquerades"
  }

  resources :users, constraints: { id: /[^\/]+/ } do

    resources :roles, only: [:create,:destroy]

    get :autocomplete_user_hruid, :on => :collection
    get :search_by_id, :on => :collection
    get :sync, to: 'users#sync_with_gram', on: :member
  end

  get 'roles' => 'roles#index'
end
