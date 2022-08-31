require "capybara/rails"
require "selenium-webdriver"
require "webdrivers/chromedriver"

Webdrivers.install_dir = File.expand_path("~/.webdrivers/#{ENV.fetch('TEST_ENV_NUMBER', nil)}")

Capybara.default_max_wait_time = 10
Capybara.server = :puma, { Silent: true }
Capybara.server_port = 9887 + ENV["TEST_ENV_NUMBER"].to_i

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless

    unless ViteRuby.instance.dev_server_running?
      raise "The Vite dev server is not running. run bin/vite dev --mode=test to start it"
    end
  end

  config.after(type: :system) do |example|
    if example.exception
      filename = example.location.parameterize

      save_page("#{filename}.html")
      begin
        save_screenshot("#{filename}.png")
      rescue Capybara::NotSupportedByDriverError => error
        Rails.logger.error(error)
      end
    end
  end
end
