Rails.application.routes.draw do
  resources :photos, only: [:index]

  root 'photos#index'

  get '*path', to: 'photos#index'
end
