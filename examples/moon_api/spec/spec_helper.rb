# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require "rack/test"
require "rspec"
require_relative "../app"

module RequestHelpers
  include Rack::Test::Methods

  def app
    MoonApi::App
  end

  def json_response
    JSON.parse(last_response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include RequestHelpers
  config.disable_monkey_patching!
  config.order = :random
end
