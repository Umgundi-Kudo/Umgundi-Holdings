require "rails_helper"

RSpec.describe "Email verification", type: :request do
  describe "GET /verify-email" do
    let(:user) do
      create(
        :user,
        email_verified: false,
        email_verification_token: "valid-token",
        email_verification_sent_at: 1.hour.ago,
        password: "password123",
        password_confirmation: "password123"
      )
    end

    context "with a valid token" do
      it "verifies the email and redirects to login with success message" do
        get verify_email_path, params: { token: user.email_verification_token }

        user.reload

        expect(user.email_verified).to be true
        expect(user.email_verification_token).to be_nil
        expect(user.email_verification_sent_at).to be_nil

        expect(response).to redirect_to(login_path)
        follow_redirect!

        expect(response.body).to include("Email verified")
      end
    end

    context "with an invalid token" do
      it "redirects to login with an error message" do
        get verify_email_path, params: { token: "invalid-token" }

        expect(response).to redirect_to(login_path)
        follow_redirect!

        expect(response.body).to include("Invalid")
      end
    end
  end
end
