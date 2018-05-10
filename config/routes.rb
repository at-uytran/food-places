Rails.application.routes.draw do
  root "static_pages#home"
  resources :places do
    resources :user_ratings
    resources :orders
    resources :user_place_orders
  end
  namespace :admin do
    root "static_pages#home"
    resources :places
  end
  resources :nearby_places
  resources :provinces
  resources :users
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
