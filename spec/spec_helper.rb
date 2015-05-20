require 'rspec/its'
require 'factory_girl'
require 'my_data_processors'
require 'support/factories'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
