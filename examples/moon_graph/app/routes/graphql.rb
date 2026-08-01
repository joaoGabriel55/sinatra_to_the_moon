# frozen_string_literal: true

module MoonGraph
  module Routes
    module GraphQL
      def self.registered(app)
        app.post "/graphql" do
          input = json_params
          result = MoonGraph::GraphQL::Schema.execute(
            input.fetch(:query),
            variables: input[:variables] || {},
            operation_name: input[:operationName],
            context: { request: request }
          )
          json result.to_h
        end
      end
    end
  end
end
