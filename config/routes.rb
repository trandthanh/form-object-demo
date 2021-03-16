Rails.application.routes.draw do
  root to: 'pages#home'

  resources :team_forms, only: [:new, :create]
  resources :teams, only: [:index]
end
