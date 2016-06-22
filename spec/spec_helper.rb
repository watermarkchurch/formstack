$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'formstack'
require 'rspec/mocks'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
