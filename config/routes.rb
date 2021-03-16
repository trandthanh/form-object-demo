Rails.application.routes.draw do
  root to: 'pages#home'

  resources :teams, only: [:index, :new, :create]
end
