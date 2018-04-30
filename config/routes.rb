Rails.application.routes.draw do
  root "static_pages#home"
  resources :places
  resources :provinces
  resources :users
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
