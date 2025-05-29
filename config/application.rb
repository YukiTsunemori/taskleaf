require_relative "boot"
# require "csv"
require "rails/all"

Bundler.require(*Rails.groups)

module Taskleaf
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.time_zone = "Asia/Tokyo"
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config/locales/ja.yml").to_s]
  end
end
