# frozen_string_literal: true

require "json"

module MoonGraph
  module HTTP
    module JSON
      def json(payload, status: 200)
        content_type :json
        halt status, ::JSON.generate(payload)
      end

      def json_params
        ::JSON.parse(request.body.read, symbolize_names: true)
      rescue ::JSON::ParserError
        json({ errors: [{ message: "Invalid JSON" }] }, status: 400)
      end
    end
  end
end
