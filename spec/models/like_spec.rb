require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "associations" do
    it "belongs to a user" do
      user = User.create!(username: "sam", email: "sam@gmail.com", password: "password")
      kudo = Kudo.create!(
        message: "sam Kudo",
        category: "Teamwork",
        sender: user,
        receiver: User.create!(username: "receiver", email: "receiver@gmail.com", password: "password")
      )
      like = Like.new(user: user, kudo: kudo)
      
      expect(like.user).to eq(user)
      expect(like.kudo).to eq(kudo)
    end
  end

  describe "validations" do
    it "does not allow a user to like the same kudo twice" do
      user = User.create!(username: "sam", email: "sam@gmail.com", password: "password")
      kudo = Kudo.create!(
        message: "sam Kudo",
        category: "Teamwork",
        sender: user,
        receiver: User.create!(username: "receiver", email: "receiver@gmail.com", password: "password")
      )

      Like.create!(user: user, kudo: kudo)
      duplicate_like = Like.new(user: user, kudo: kudo)

      expect(duplicate_like.valid?).to be_falsey
      expect(duplicate_like.errors[:user_id]).to include("can only like a kudo once")
    end
  end
end
