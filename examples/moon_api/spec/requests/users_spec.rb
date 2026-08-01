# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Users API" do
  it "lists users" do
    get "/api/users"

    expect(last_response).to be_ok
    expect(json_response).to eq(data: [{ id: 1, name: "Frank" }])
  end

  it "creates a user" do
    header "content-type", "application/json"
    post "/api/users", JSON.generate(name: "Luna")

    expect(last_response.status).to eq(201)
    expect(json_response).to eq(data: { id: 2, name: "Luna" })
  end
end
