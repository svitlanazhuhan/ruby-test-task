require 'capybara/rspec'
require 'delegate'
require 'date'
require 'pry'
require 'selenium-webdriver'
require 'webdrivers'

require_relative 'support/api_client'
require_relative 'support/combobox'
require_relative 'support/pages/home_page'

# Register Chrome with Selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Set Capybara default driver
Capybara.default_driver = :selenium

# Set the default maximum wait time for finding elements
Capybara.default_max_wait_time = 10

# Set the default application host
Capybara.app_host = 'https://www.aircanada.com'

RSpec.configure do |config|
  config.before(:each) do
    # Set the browser window size before each test
    Capybara.current_session.driver.browser.manage.window.resize_to(1280, 800)
  end

  config.after(:each) do
    Capybara.reset_sessions!
  end
end