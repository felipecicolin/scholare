require "capybara/rails"
require "selenium-webdriver"
require "webdrivers/chromedriver"

Webdrivers.install_dir = File.expand_path("~/.webdrivers/")

Capybara.default_max_wait_time = 10
Capybara.server = :puma, { Silent: true }
Capybara.server_port = 9887

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.args << "--headless"
  options.args << "--disable-gpu"
  options.args << "--no-sandbox"
  options.args << "--window-size=1920,1080"
  options.args << "--disable-dev-shm-usage"

  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :headless_chrome
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
