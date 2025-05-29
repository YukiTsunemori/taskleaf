Rails.application.routes.draw do
  root to: "tasks#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # routes.rbでnamespace :adminとしたことで、URLに/admin、ヘルパーメソッドにadmin_がつくようになる。
  namespace :admin do
    resources :users
  end

  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
  end
  # 上記のように、resources :tasks do ... endの中で、post :confirmとすることで、
  # タスクの新規登録の確認画面を表示するためのルーティングを追加できる。
  # このルーティングは、POSTリクエストを受け付け、confirm_newアクションを呼び出す。
  # on: :newは、newアクションに対してのみ適用されることを示す。
end
