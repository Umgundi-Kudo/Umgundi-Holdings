require "rails_helper"

RSpec.describe Sessions::Authenticate do
  describe ".call" do
    let!(:user) do
      User.create!(
        username: "konke",
        email: "konke@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    context "when credentials are valid" do
      it "returns the user" do
        result = described_class.call(
          username: "konke",
          password: "password123"
        )

        expect(result).to eq(user)
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
  end
end
