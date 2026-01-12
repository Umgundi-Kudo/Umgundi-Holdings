require 'rails_helper'

RSpec.describe Kudo, type: :model do
  let(:sender) do
    User.create!(
      username: "sender",
      email: "sender@gmail.com",
      password: "12345678910",
      password_confirmation: "12345678910"
    )
  end

  let(:receiver) do
    User.create!(
      username: "receiver",
      email: "receiver@gmail.com",
      password: "2468101214",
      password_confirmation: "2468101214"
    )
  end

  let(:other_user) do
    User.create!(
      username: "other",
      email: "other@gmail.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  before do
    Kudo.create!(sender: sender, receiver: receiver, category: 'Leadership', message: 'Great work!')
    Kudo.create!(sender: sender, receiver: other_user, category: 'Teamwork', message: 'Well done!')
    Kudo.create!(sender: receiver, receiver: sender, category: 'Gratitude', message: 'Thanks!')
  end

  it 'creates a valid kudo' do
    kudo = Kudo.new(
      sender: sender,
      receiver: receiver,
      category: 'Teamwork',
      message: 'Great job!'
    )

    expect(kudo).to be_valid
  end

  it 'is invalid without a sender' do
    kudo = Kudo.new(
      receiver: receiver,
      category: 'Teamwork',
      message: 'Nice work'
    )

    expect(kudo).not_to be_valid
  end

  it 'is invalid without a receiver' do
    kudo = Kudo.new(
      sender: sender,
      category: 'Teamwork',
      message: 'Nice work'
    )

    expect(kudo).not_to be_valid
  end

  it 'is invalid without a category' do
    kudo = Kudo.new(
      sender: sender,
      receiver: receiver,
      message: 'Nice work'
    )

    expect(kudo).not_to be_valid
  end

  it 'is invalid if message is too long' do
    kudo = Kudo.new(
      sender: sender,
      receiver: receiver,
      message: 'a' * 501,
      category: 'Teamwork'
    )

    expect(kudo).not_to be_valid
  end

  it 'persists a kudo to the database' do
    expect {
      Kudo.create!(
        sender: sender,
        receiver: receiver,
        category: 'Leadership',
        message: 'Excellent leadership!'
      )
    }.to change { Kudo.count }.by(1)
  end

  describe 'scopes' do
    it 'returns all kudos sent by a user' do
      kudos_sent_by_sender = Kudo.sent_by(sender)
      expect(kudos_sent_by_sender.count).to eq(2)
      expect(kudos_sent_by_sender.map(&:receiver)).to contain_exactly(receiver, other_user)
    end

    it 'returns all kudos received by a user' do
      kudos_received_by_sender = Kudo.received_by(sender)
      expect(kudos_received_by_sender.count).to eq(1)
      expect(kudos_received_by_sender.first.sender).to eq(receiver)
    end
  end
end
