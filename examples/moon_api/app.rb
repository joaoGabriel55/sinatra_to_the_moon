# frozen_string_literal: true

require "sinatra/base"
require_relative "app/http/json"
require_relative "app/routes/health"
require_relative "app/routes/users"

module MoonApi
  class App < Sinatra::Base
    helpers HTTP::JSON
    register Routes::Health
    register Routes::Users

    configure do
      set :show_exceptions, false
    end

    not_found do
      json({ error: "not_found" }, status: 404)
    end

    error do
      json({ error: "internal_server_error" }, status: 500)
    end
  end
end
