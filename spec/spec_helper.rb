$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'formstack'
require 'rspec/mocks'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before :suite do
    WebMock.disable_net_connect!
  end

  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
