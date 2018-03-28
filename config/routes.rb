Rails.application.routes.draw do
  root 'home#index'

  get 'login', to: 'home#log_in'
  post 'login', to: 'home#submit'
  post 'logout', to: 'home#log_out'

  get '/employeeportal/guestsearch', to: 'employeeportal#search', as: 'search_guest'
  get '/employeeportal/:id', to: 'employeeportal#index'

  resources :reserves
  resources :employees
  resources :guests
  resources :bookings
  resources :facilities
  resources :locations
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
