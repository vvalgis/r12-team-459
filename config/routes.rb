R12Team459::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match "dashboard" => "dashboard#index", as: :dashboard
  resources :entries
  root to: 'pages#home'
end
