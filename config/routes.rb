Seshly::Application.routes.draw do
  root :to => "home#index"
  
  resources :users
  resources :posts
  resources :locations
  
  match '/location_search' => "location_search#index"
  match '/location_search/save_token' => "location_search#save_token"
  
  
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  
end
