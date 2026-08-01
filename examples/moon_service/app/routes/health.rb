# frozen_string_literal: true

require "json"

module MoonService
  module Routes
    module Health
      def self.registered(app)
        app.get "/health" do
          content_type :json
          JSON.generate(status: "ok")
        end
      end
    end
  end
end
