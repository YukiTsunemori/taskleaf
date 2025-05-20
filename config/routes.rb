Rails.application.routes.draw do
  root to: "tasks#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # routes.rbでnamespace :adminとしたことで、URLに/admin、ヘルパーメソッドにadmin_がつくようになる。
  namespace :admin do
    resources :users
  end
  resources :tasks
end
