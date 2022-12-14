# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

Dotenv::Railtie.load if %w[development test].include? ENV["RAILS_ENV"]

module Scholare
  class Application < Rails::Application
    config.load_defaults 7.0

    config.i18n.load_path += Dir[Rails.root.join("config/locales/**.{yml}")]
    config.i18n.default_locale = "pt-BR"
    config.time_zone = "Brasilia"

    config.generators.system_tests = nil
  end
end
