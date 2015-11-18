Rails.application.routes.draw do
  root 'application#welcome'


  resources :users, only: [:new, :create]
  get '/results'

  #session
  # get '/session' => 'session#current_user' 
  post '/session'
  delete '/session'
end
