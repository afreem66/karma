Rails.application.routes.draw do
  root 'application#welcome'


  resources :users, only: [:new, :create]
  get '/results' => 'application#results'
  get '/sign_up' => 'application#sign_up'
  get '/log_in' => 'application#log_in'

  #session
  # get '/session' => 'session#current_user'
  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'
end
