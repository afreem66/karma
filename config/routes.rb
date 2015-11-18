Rails.application.routes.draw do
  resources :opportunities
  root 'application#welcome'


  resources :users, only: [:new, :create]
  get '/sign_up' => 'application#sign_up'
  get '/log_in' => 'application#log_in'
  get '/find' => 'application#search'
  post '/find' => 'opportunities#find'
  get '/results' => 'opportunities#results'
  #session
  # get '/session' => 'session#current_user'
  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'
end
