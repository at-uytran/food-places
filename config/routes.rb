Rails.application.routes.draw do
  root "static_pages#home"
  resources :places do
    resources :user_ratings
    resources :orders
    resources :user_place_orders
    resources :request_owners
    get "/foods_timeline", to: "places#foods_timeline"
    get "/reviews_timeline", to: "places#reviews_timeline"
  end
  resources :maps, only: %i(show)
  namespace :admin do
    root "static_pages#home"
    resources :places
    resources :users
  end
  resources :nearby_places
  resources :provinces
  resources :users
  resources :orders
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
