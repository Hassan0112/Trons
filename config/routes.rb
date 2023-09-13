Rails.application.routes.draw do
  root 'home#index'
  # get '/logout', to: 'session#logout', as: 'logout'
  
  devise_for :users
end
