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
      let(:receiver) { create(:user) }

      let!(:older_kudo) do
        create(
          :kudo,
          sender: user,
          receiver: receiver,
          message: "Older kudo",
          created_at: 2.days.ago
        )
      end

      let!(:newer_kudo) do
        create(
          :kudo,
          sender: user,
          receiver: receiver,
          message: "Newer kudo",
          created_at: 1.hour.ago
        )
      end

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

      it "displays kudos in reverse chronological order" do
        get dashboard_path

        body = response.body

        expect(body).to include("Newer kudo")
        expect(body).to include("Older kudo")
        expect(body.index("Newer kudo")).to be < body.index("Older kudo")
      end
    end
  end
end
