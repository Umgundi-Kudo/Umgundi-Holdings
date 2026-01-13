require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "renders the login page" do
      get login_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /login" do
    context "with valid credentials" do
      let(:user) { create(:user) }

      it "logs the user in and redirects to dashboard" do
        result = OpenStruct.new(success?: true, user: user)

        allow(Sessions::Authenticate)
          .to receive(:call)
          .and_return(result)

        post login_path, params: {
          email: user.email,
          password: "password"
        }

        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "with invalid credentials" do
      it "re-renders the login page with error" do
        result = OpenStruct.new(
          success?: false,
          error: "Invalid email or password"
        )

        allow(Sessions::Authenticate)
          .to receive(:call)
          .and_return(result)

        post login_path, params: {
          email: "wrong@email.com",
          password: "badpassword"
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Invalid email or password")
      end
    end
  end
end
