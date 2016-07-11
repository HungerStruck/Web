Rails.application.routes.draw do
  #devise_for :users
  root 'info#index'

  resources :matches, only: [:index, :show]
  resources :revisions, only: [:index]
  resources :stats, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
