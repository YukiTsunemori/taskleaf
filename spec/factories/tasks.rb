FactoryBot.define do
  factory :task do
    name { "テストを書く" }
    description { "Rspec&Capybara&FactoryBotを準備する" }
    user
    # users.rb内で定義した、:userという名前のfactoryを、
    # Taskモデルに定義されたuserという名前の関連を生成するのに利用する。という意味になる。
  end
end
