Rails.application.routes.draw do
  root 'home#index'
    get '/logout', to: 'session#logout', as: 'logout'  
  devise_for :users, controllers: { registrations: 'users' }

  get '/profile', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile', to: 'users#profile', as: 'user_profile'
  patch '/update_profile_picture', to: 'users#update_profile_picture', as: 'update_profile_picture'
  get 'used-cars/sell', to: 'used_cars#new_ad'
  get '/post-ad' , to: 'used_cars#new_ad'
  get '/change_password', to: 'users#edit_password', as: 'change_password'
  patch '/change_password', to: 'users#update_password'

end