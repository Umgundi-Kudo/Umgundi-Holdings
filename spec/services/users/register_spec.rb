require "rails_helper"

RSpec.describe Users::Register do
  describe ".call" do
    let(:params) do
      {
        username: "konke",
        email: "konke@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    end

    it "creates a user and sends verification email" do
      mailer = double(deliver_later: true)
      allow(UserMailer).to receive(:verify_email).and_return(mailer)

      result = described_class.call(**params)

      expect(result.success?).to be true

      user = result.user
      expect(user).to be_persisted
      expect(user.email_verified).to be false
      expect(user.email_verification_token).to be_present
      expect(user.email_verification_sent_at).to be_present

      expect(UserMailer).to have_received(:verify_email).with(user)
    end

    it "fails when params are invalid" do
      result = described_class.call(**params.merge(email: ""))

      expect(result.success?).to be false
      expect(result.error).to be_present
    end
  end
end
