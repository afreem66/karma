Rails.application.routes.draw do
  root 'application#welcome'

  resources :users, only: [:new, :create]
  get 'application#results'
end
