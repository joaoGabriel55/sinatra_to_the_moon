# frozen_string_literal: true

require_relative "../models/page"

module MoonApp
  module Controllers
    module Home
      def self.registered(app)
        app.get "/" do
          @page = Models::Page.new(
            title: "moon_app",
            heading: "Sinatra to the Moon",
            message: "A concise Sinatra app with views and Tailwind CSS."
          )

          erb :home
        end
      end
    end
  end
end
