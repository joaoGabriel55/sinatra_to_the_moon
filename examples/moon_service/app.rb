# frozen_string_literal: true

require "sinatra/base"
require_relative "app/routes/health"

module MoonService
  class App < Sinatra::Base
    register Routes::Health

    configure do
      set :show_exceptions, false
    end
  end
end
