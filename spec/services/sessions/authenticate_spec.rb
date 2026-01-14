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
      it "returns a successful result with the user" do
        result = described_class.call(
          email: verified_user.email,
          password: "password123"
        )

        expect(result.success?).to be(true)
        expect(result.user).to eq(verified_user)
      end
    end

    context "when password is invalid" do
      it "returns a failure result with an error message" do
        result = described_class.call(
          email: verified_user.email,
          password: "wrong-password"
        )

        expect(result.success?).to be(false)
        expect(result.error).to eq("Invalid email or password")
      end
    end

    context "when email does not exist" do
      it "returns a failure result with an error message" do
        result = described_class.call(
          email: "unknown@example.com",
          password: "password123"
        )

        expect(result.success?).to be(false)
        expect(result.error).to eq("Invalid email or password")
      end
    end

    context "when email is not verified" do
      it "returns a failure result with a verification error" do
        result = described_class.call(
          email: unverified_user.email,
          password: "password123"
        )

        expect(result.success?).to be(false)
        expect(result.error).to eq(
          "Please verify your email before logging in"
        )
      end
    end
  end
end
