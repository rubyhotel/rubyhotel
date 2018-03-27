Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :reserves
  resources :employees
  resources :guests
  resources :bookings
  resources :facilities
  resources :locations
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
