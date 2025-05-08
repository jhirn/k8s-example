require 'rails_helper'

RSpec.describe "Timestamps", type: :request do
  include ActiveSupport::Testing::TimeHelpers
  describe "GET /" do
    let(:parsed_response) { JSON.parse(response.body) }

    around do |example|
      freeze_time do
        get root_url
        example.run
      end
    end

    it "returns a 200 status" do
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include("application/json")
    end

    it "returns the current timestamp" do
      expect(parsed_response["timestamp"]).to eq(Time.now.to_i)
    end

    it "returns the expected message" do
      expect(parsed_response["message"]).to eq("Automate all the things!")
    end
  end
end
