Rails.application.routes.draw do
  # routes.rbでnamespace :adminとしたことで、URLに/admin、ヘルパーメソッドにadmin_がつくようになる。
  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'
  resources :tasks
end
