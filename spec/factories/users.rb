FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    sequence(:email) { |n| "test#{n}@email.com" }  # ←ここを変更
    password { "password" }
    password_confirmation { "password" }
  end

  # factoryメソッドを利用して、:userという名前のUserクラスのファクトリをを定義する。
  # クラスを:userという名前から自動で類推してくれるが、
  # ファクトリ名とクラス名が異なる場合には、:classオブションをでクラスを指定できる。
end
