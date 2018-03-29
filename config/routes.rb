Rails.application.routes.draw do

  get 'guestportal/index'

  get 'home/index'

  root 'home#index'

  get 'login', to: 'home#log_in'
  post 'login', to: 'home#submit'
  post 'logout', to: 'home#log_out'

  get '/guestportal/:id', to: 'guestportal#index', as: 'guest_portal'
  get '/guestportal/:id/bookingedit', to: 'guestportal#bookingedit', as: 'edit_guest_booking'
  get '/guestportal/:id/infoedit', to: 'guestportal#infoedit', as: 'edit_guest_info'
  get '/guestportal/:id/bookingcreate', to: 'guestportal#bookingcreate', as: 'create_guest_booking'
  post 'findrooms', to: 'guestportal#findrooms'
  post 'createbooking', to: 'guestportal#bookroom'
  delete 'deletebooking', to: 'guestportal#deletebooking'

  resources :reserves
  resources :employees
  resources :guests
  resources :bookings
  resources :facilities
  resources :locations
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
