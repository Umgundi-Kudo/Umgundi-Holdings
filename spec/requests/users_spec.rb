require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /signup" do
    let(:valid_params) do
      {
        user: {
          username: "konke",
          email: "konke@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    before do
      mailer = double(deliver_later: true)
      allow(UserMailer).to receive(:verify_email).and_return(mailer)
    end

    it "creates a new user and sends verification email" do
      expect {
        post signup_path, params: valid_params
      }.to change(User, :count).by(1)

      user = User.last

      expect(user.email_verified).to be false
      expect(user.email_verification_token).to be_present
      expect(user.email_verification_sent_at).to be_present

      expect(UserMailer).to have_received(:verify_email).with(user)
      expect(response).to redirect_to(login_path)
    end

    it "does not create user with invalid params" do
      invalid_params = valid_params.deep_merge(
        user: { email: "" }
      )

      expect {
        post signup_path, params: invalid_params
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
