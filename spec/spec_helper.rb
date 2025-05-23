  # See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
  # RspecでCopybaraを使用するための準備を行う。capybara本体はrails new実行時に自動でinstall済み。
  require "capybara/rspec"

  RSpec.configure do |config|
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
