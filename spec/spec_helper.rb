require 'pry'
require 'rspec'
require 'capybara/rspec'
require 'selenium-webdriver'

require_relative '../server.rb'

set :environment, :test

Capybara.app = Sinatra::Application

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
