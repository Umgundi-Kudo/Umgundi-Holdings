require "rails_helper"

RSpec.describe "Email verification", type: :request do
  describe "GET /verify-email" do
    context "with a valid token" do
      it "redirects to login with success notice" do
        result = OpenStruct.new(success?: true)

        allow(Users::VerifyEmail)
          .to receive(:call)
          .and_return(result)

        get verify_email_path, params: { token: "valid-token" }

        expect(response).to redirect_to(login_path)
        follow_redirect!
        expect(response.body).to include("Email verified")
      end
    end

    context "with an invalid token" do
      it "redirects to login with error alert" do
        result = OpenStruct.new(
          success?: false,
          error: "Invalid or expired token"
        )

        allow(Users::VerifyEmail)
          .to receive(:call)
          .and_return(result)

        get verify_email_path, params: { token: "bad-token" }

        expect(response).to redirect_to(login_path)
        follow_redirect!
        expect(response.body).to include("Invalid or expired token")
      end
    end
  end
end
