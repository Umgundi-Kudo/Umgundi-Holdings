require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before do
    Rails.application.routes.default_url_options[:host] = "example.com"
  end

  describe "#verify_email" do
    let(:user) do
      create(
        :user,
        email: "konke@example.com",
        email_verification_token: "test-token-123",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    let(:mail) { described_class.verify_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Verify your email")
      expect(mail.to).to eq(["konke@example.com"])
      expect(mail.from).to be_present
    end

    it "includes the verification link with token" do
      expect(mail.body.encoded).to include("test-token-123")
      expect(mail.body.encoded).to include("example.com")
    end
  end
end
