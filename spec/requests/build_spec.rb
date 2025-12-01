
require 'rails_helper'

RSpec.describe "Builds", type: :request do
  let!(:user) { create(:user) }
  let!(:gun) { create(:gun) }
  let!(:build) { create(:build, user: user, gun: gun) }

  describe "GET /builds" do
    it "returns a successful response" do
      get builds_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /builds/:id" do
    it "returns the build" do
      get build_path(build)
      expect(response).to have_http_status(:success)
    end
  end
end
