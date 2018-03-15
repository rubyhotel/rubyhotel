Rails.application.routes.draw do
  resources :reserves
  resources :guests
  resources :employees
  resources :bookings
  resources :rooms
  resources :facilities
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
