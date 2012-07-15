Seshly::Application.routes.draw do
  root :to => "home#index"
  
  resources :users
  resources :posts
  resources :locations
  resources :venues, :only => 'index'
  
  match '/geocoder_test' => 'locations#geocoder_test'
  
  match '/attend/:id' => 'attendances#create'
  match '/unattend/:id' => 'attendances#destroy'
  
  match '/location_search' => "location_search#index"
  match '/location_search/save_token' => "location_search#save_token"
  match '/location_search/show_venue_raw' => "location_search#show_venue_raw"
  
  
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  
end
