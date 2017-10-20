ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = 'random'
end
