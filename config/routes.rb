Seshly::Application.routes.draw do
  resources :posts
  resources :locations
  
  match '/location_search' => "location_search#index"

  root :to => "home#index"
  resources :users
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
