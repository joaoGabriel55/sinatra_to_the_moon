# frozen_string_literal: true

require "sinatra/base"
require_relative "app/graphql/schema"
require_relative "app/http/json"
require_relative "app/routes/graphql"
require_relative "app/routes/health"

module MoonGraph
  class App < Sinatra::Base
    helpers HTTP::JSON
    register Routes::GraphQL
    register Routes::Health

    configure do
      set :show_exceptions, false
    end
  end
end
