# frozen_string_literal: true

require "spec_helper"

RSpec.describe "GET /health" do
  it "reports that the application is healthy" do
    get "/health"

    expect(last_response).to be_ok
    expect(last_response.content_type).to start_with("application/json")
    expect(json_response).to eq(status: "ok")
  end
end
