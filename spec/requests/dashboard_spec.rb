require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /dashboard" do
    context "when user is not logged in" do
      it "redirects to login" do
        get dashboard_path
        expect(response).to redirect_to(login_path)
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before do
        post login_path, params: {
          email: user.email,
          password: "password"
        }
      end

      it "returns http success" do
        get dashboard_path
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
