# frozen_string_literal: true

require "graphql"

module MoonGraph
  module GraphQL
    class Query < ::GraphQL::Schema::Object
      field :hello, String, null: false

      def hello
        "Fly me to the moon"
      end
    end

    class Schema < ::GraphQL::Schema
      query Query
    end
  end
end
