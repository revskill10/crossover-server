Rails.application.routes.draw do
  get 'metrics/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
  root 'home#index'
  resources :metrics, only: [:create]
end
