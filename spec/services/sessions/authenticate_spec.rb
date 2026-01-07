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

    it "returns the user when credentials are valid" do
      result = described_class.call(
        username: "konke",
        password: "password123"
      )

      expect(result).to eq(user)
    end
  end
end
