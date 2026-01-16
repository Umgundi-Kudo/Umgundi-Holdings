require "rails_helper"

RSpec.describe Users::Register do
  describe ".call" do
    let(:valid_params) do
      {
        username: "konke",
        email: "konke@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    end

    before do
      mailer = double(deliver_later: true)
      allow(UserMailer).to receive(:verify_email).and_return(mailer)
    end

    context "when params are valid" do
      it "creates a user and sends verification email" do
        expect {
          result = described_class.call(valid_params)

          expect(result.success?).to be true

          user = result.user
          expect(user).to be_persisted
          expect(user.email_verified).to be false
          expect(user.email_verification_token).to be_present
          expect(user.email_verification_sent_at).to be_present
        }.to change(User, :count).by(1)

        expect(UserMailer).to have_received(:verify_email).with(User.last)
      end
    end

    context "when params are invalid" do
      it "does not create a user and returns an error" do
        result = described_class.call(valid_params.merge(email: ""))

        expect(result.success?).to be false
        expect(result.error).to be_present
      end
    end

    context "when an unexpected error occurs" do
      it "returns a generic error message" do
        allow(User).to receive(:new).and_raise(StandardError.new("boom"))

        result = described_class.call(valid_params)

        expect(result.success?).to be false
        expect(result.error).to eq("Something went wrong. Please try again.")
      end
    end
  end
end
