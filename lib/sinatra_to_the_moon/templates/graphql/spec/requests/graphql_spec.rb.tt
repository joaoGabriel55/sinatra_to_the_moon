# frozen_string_literal: true

require "spec_helper"

RSpec.describe "POST /graphql" do
  it "executes a query" do
    header "content-type", "application/json"
    post "/graphql", JSON.generate(query: "{ hello }")

    expect(last_response).to be_ok
    expect(json_response).to eq(data: { hello: "Fly me to the moon" })
  end
end
