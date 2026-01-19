require "rails_helper"

RSpec.describe "Likes", type: :request do
  let(:user) do
    create(
      :user,
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:receiver) do
    create(
      :user,
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:kudo) do
    Kudo.create!(
      sender: user,
      receiver: receiver,
      category: "Teamwork",
      message: "Great job!"
    )
  end

  before do
    post login_path, params: {
      email: user.email,
      password: "password123"
    }
  end

  describe "POST /kudos/:kudo_id/like" do
    it "creates a like for the current user" do
      expect {
        post kudo_like_path(kudo)
      }.to change(Like, :count).by(1)

      like = Like.last
      expect(like.user).to eq(user)
      expect(like.kudo).to eq(kudo)
    end

    it "redirects to the dashboard for html requests" do
      post kudo_like_path(kudo)
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "DELETE /kudos/:kudo_id/like" do
    before do
      kudo.likes.create!(user: user)
    end

    it "removes the like for the current user" do
      expect {
        delete kudo_like_path(kudo)
      }.to change(Like, :count).by(-1)
    end

    it "redirects to the dashboard for html requests" do
      delete kudo_like_path(kudo)
      expect(response).to redirect_to(dashboard_path)
    end

    it "does not error if the like does not exist" do
      Like.delete_all

      expect {
        delete kudo_like_path(kudo)
      }.not_to raise_error
    end
  end

  context "when not logged in" do
    before do
      delete logout_path
    end

    it "redirects to dashboard when liking" do
      post kudo_like_path(kudo)
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to dashboard when unliking" do
      delete kudo_like_path(kudo)
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
