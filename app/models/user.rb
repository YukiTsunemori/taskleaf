class User < ApplicationRecord
  has_secure_password
  # has_secure_passwordを記述すると、DBのカラムには対応しない属性が2つ追加される。
  # 1つはpassword属性。これはユーザーが入力した生のパスワードを一時的に格納するための属性。
  # 2つはpassword_confirmation属性。1つ目のpasswordと一致しなければ検証に失敗する。これも一時的。
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  has_many :tasks
end
