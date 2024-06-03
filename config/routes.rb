Rails.application.routes.draw do
  root 'home#index'
    get '/logout', to: 'session#logout', as: 'logout'  
  devise_for :users, controllers: { registrations: 'users' }

  get '/profile', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile', to: 'users#profile', as: 'user_profile'
  patch '/update_profile_picture', to: 'users#update_profile_picture', as: 'update_profile_picture'
  get '/used-cars/sell', to: 'used_cars#post_ad', as: 'used_cars_sell'
  get '/used-cars/sell/post-ad', to: 'used_cars#new_ad', as: 'used_cars_sell_post_ad'
  get '/change_password', to: 'users#edit_password', as: 'change_password'
  post '/used-cars/sell' , to: 'used_cars#submit_form'
  patch '/change_password', to: 'users#update_password'
  get '/products/pakwheels-sell-it-for-me/new', to: 'products#pakwheels_sell_it_for_me_new'
  post '/products/pakwheels-sell-it-for-me/new', to: 'products#submit_form', as: 'submit_sellitforme_form'
  get '/account_verification', to: 'products#show', as: 'account_verification'
  post '/send_message', to: 'products#send_message', as: 'send_message'
  post 'verify_code', to: 'products#verify_code'
  post 'resend_code', to: 'products#resend_code'

end
