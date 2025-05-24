FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test1@email.com" }
    password { "password" }
  end

  # factoryメソッドを利用して、:userという名前のUserクラスのファクトリをを定義する。
  # クラスを:userという名前から自動で類推してくれるが、
  # ファクトリ名とクラス名が異なる場合には、:classオブションをでクラスを指定できる。
end
