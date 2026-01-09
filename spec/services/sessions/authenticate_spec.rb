require "rails_helper"

RSpec.describe Sessions::Authenticate do
  describe ".call" do
    let!(:verified_user) do
      User.create!(
        username: "konke",
        email: "konke@example.com",
        password: "password123",
        password_confirmation: "password123",
        email_verified: true
      )
    end

    let!(:unverified_user) do
      User.create!(
        username: "unverified",
        email: "unverified@example.com",
        password: "password123",
        password_confirmation: "password123",
        email_verified: false
      )
    end

    context "when credentials are valid and email is verified" do
      it "returns the user" do
        result = described_class.call(
          username: "konke",
          password: "password123"
        )

        expect(result).to eq(verified_user)
      end
    end

    context "when password is invalid" do
      it "returns nil" do
        result = described_class.call(
          username: "konke",
          password: "wrong-password"
        )

        expect(result).to be_nil
      end
    end

    context "when username does not exist" do
      it "returns nil" do
        result = described_class.call(
          username: "unknown-user",
          password: "password123"
        )

        expect(result).to be_nil
      end
    end

    context "when email is not verified" do
      it "returns nil even if password is correct" do
        result = described_class.call(
          username: "unverified",
          password: "password123"
        )

        expect(result).to be_nil
      end
    end
  end
end
