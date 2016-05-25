Rails.application.routes.draw do
  mount MongoidForums::Engine, :at => "/forums"
  devise_for :users
  root 'info#index'

  resources :matches, only: [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
