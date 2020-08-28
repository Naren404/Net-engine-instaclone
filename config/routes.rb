Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  resources :photos, only: [:index]

  root 'photos#index'

  get '*path', to: 'photos#index'
end
