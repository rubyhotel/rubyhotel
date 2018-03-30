Rails.application.routes.draw do

  get 'guestportal/index'

  get 'home/index'

  root 'home#index'

  get 'login', to: 'home#log_in'
  post 'login', to: 'home#submit'
  post 'logout', to: 'home#log_out'

  get '/employeeportal/:id/guesthelp/:gid', to: 'employeeportal#helper', as: 'ghelper'
  delete '/employeeportal/:id/guesthelp/:gid/:bid', to: 'employeeportal#destroy', as: 'del_ghelper'
  get '/employeeportal/:id/guestsearch', to: 'employeeportal#search', as: 'search_guest'
  get '/employeeportal/:id/guesthelp/:gid/newbooking', to: 'employeeportal#new', as: 'new_ghelper'
  post '/employeeportal/:id/guesthelp/:gid/newbooking', to: 'employeeportal#newpost'
  get '/employeeportal/:id/guesthelp/:gid/booking/:bid', to: 'employeeportal#show', as: 'show_ghelper'
  get '/employeeportal/:id/guesthelp/:gid/editbooking/:bid', to: 'employeeportal#edit', as: 'edit_ghelper'
  post '/employeeportal/:id/guesthelp/:gid/editbooking/:bid', to: 'employeeportal#editpost'
  get '/employeeportal/:id', to: 'employeeportal#index', as: 'eportal'

  get '/guestportal/:id', to: 'guestportal#index', as: 'guest_portal'
  get '/guestportal/:id/bookingedit', to: 'guestportal#bookingedit', as: 'edit_guest_booking'
  get '/guestportal/:id/infoedit', to: 'guestportal#infoedit', as: 'edit_guest_info'

  get 'managerportal/:id', to: 'manager_portal#index', as: :manager_portal
  get 'agg_search', to: 'manager_portal#search_aggregate'
  get 'agg_group_by_search', to: 'manager_portal#group_by_search_aggregate'

  resources :reserves
  resources :employees
  resources :guests
  resources :bookings
  resources :facilities
  resources :locations
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
