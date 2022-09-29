require "capybara/rails"
require "selenium-webdriver"
require "webdrivers/chromedriver"

Webdrivers.install_dir = File.expand_path("~/.webdrivers/")

Capybara.default_max_wait_time = 10
Capybara.server = :puma, { Silent: true }
Capybara.server_port = 9887

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
    Capybara.page.driver.browser.manage.window.resize_to(1366, 768)
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
