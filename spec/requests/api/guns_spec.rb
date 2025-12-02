require 'rails_helper'

RSpec.describe "Api::Guns", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/guns/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/guns/show"
      expect(response).to have_http_status(:success)
    end
  end
end
