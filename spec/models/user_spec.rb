require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with username, email, and password" do
    user = User.new(
      username: "konke",
      email: "konke@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    expect(user).to be_valid
  end
end
