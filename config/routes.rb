R12Team459::Application.routes.draw do
  match "dashboard" => "dashboard#index", as: :dashboard
  resources :entries
  root to: 'pages#home'
end
