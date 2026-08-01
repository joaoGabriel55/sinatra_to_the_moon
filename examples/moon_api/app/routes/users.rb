# frozen_string_literal: true

module MoonApi
  module Routes
    module Users
      def self.registered(app)
        app.get "/api/users" do
          json({ data: [{ id: 1, name: "Frank" }] })
        end

        app.post "/api/users" do
          attributes = json_params
          json({ data: { id: 2, name: attributes.fetch(:name) } }, status: 201)
        end
      end
    end
  end
end
