# frozen_string_literal: true

# spec/support/factory_bot.rb

require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
