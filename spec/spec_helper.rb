  # See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
  require "capybara/rspec"
  # RspecでCopybaraを扱うために必要な機能を読み込み。

  RSpec.configure do |config|
  # System specを実行するドライバの設定。
  # ドライバとは、Capybaraを使ったテスト/Specにおいて、ブラウザ相当の機能を利用するために必要なプログラムのこと。
  # 今回は高速なHeadless Chromeを用いる。
  config.before(:each, type: :system) do
    driven_by :selenimu_chrome_headless
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  end
