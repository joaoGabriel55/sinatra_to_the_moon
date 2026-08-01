# frozen_string_literal: true

require "spec_helper"

RSpec.describe "GET /" do
  it "renders the home view and stylesheet" do
    get "/"

    expect(last_response).to be_ok
    expect(last_response.content_type).to start_with("text/html")
    expect(last_response.body).to include("Sinatra to the Moon")
    expect(last_response.body).to include('href="/application.css"')
  end
end
