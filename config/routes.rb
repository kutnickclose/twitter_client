TwitterClient::Application.routes.draw do
  root to: "site#index"
  resources :users, only: [:create, :show]
  resources :pairs, only: [:create, :show]
end
