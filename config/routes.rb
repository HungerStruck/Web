Rails.application.routes.draw do
  devise_for :players
  mount MongoidForums::Engine, :at => "/forums"
  root 'info#index'

  resources :games, only: [:index, :show]
  get '/events', to: 'games#events'

  resources :revisions, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Peek::Railtie => '/peek'
  root :to => 'home#show'
  mount ActionCable.server => '/cable'

  get '/newevent/:id', to: 'games#newevent'
end