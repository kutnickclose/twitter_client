TwitterClient::Application.routes.draw do
  root to: "site#index"
  resources :users, only: [:create, :show]
end
