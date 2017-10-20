ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'

RSpec.configure do |config|
  config.order = 'random'
end
