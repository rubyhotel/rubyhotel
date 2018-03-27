Rails.application.routes.draw do

  get 'guestportal/index'

  get 'home/index'

  root 'home#index'

  get 'login', to: 'home#log_in'
  post 'login', to: 'home#submit'
  post 'logout', to: 'home#log_out'

  get '/guestportal/:id', to: 'guestportal#index'
  get '/guestportal/:id/edit', to: 'guestportal#edit', as: 'edit_guest_booking'

  resources :reserves
  resources :employees
  resources :guests
  resources :bookings
  resources :facilities
  resources :locations
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
