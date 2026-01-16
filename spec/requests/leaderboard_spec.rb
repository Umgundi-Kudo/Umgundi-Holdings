require "rails_helper"

RSpec.describe "Leaderboard", type: :request do
  describe "GET /leaderboard" do
    let(:user) do
      create(
        :user,
        password: "password123",
        password_confirmation: "password123"
      )
    end

    let!(:leader) do
      create(
        :user,
        username: "TopUser",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    before do
      # Give the leader a received kudo
      create(
        :kudo,
        sender: user,
        receiver: leader
      )

      post login_path, params: {
        email: user.email,
        password: "password123"
      }
    end

    it "returns http success for logged-in users" do
      get leaderboard_path
      expect(response).to have_http_status(:ok)
    end

    it "displays leaderboard users" do
      get leaderboard_path
      expect(response.body).to include("TopUser")
    end
  end
end
