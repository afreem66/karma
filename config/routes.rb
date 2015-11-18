Rails.application.routes.draw do
  root 'application#welcome'


  resources :users, only: [:new, :create]
  get '/results' => 'application#results'

  #session
  # get '/session' => 'session#current_user'
  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'
end
