require 'rails_helper'

RSpec.describe Kudo, type: :model do
    let(:sender) do
        User.create!(
            username: "sender",
            email: 'sender@gmail.com',
            password: '12345678910',
            password_confirmation: '12345678910'
        )
    end

    let(:receiver) do
        User.create!(
            username: "receiver",
            email: 'receiver@gmail.com',
            password: '2468101214',
            password_confirmation: '2468101214'
        )
    end

    it 'creates a valid kudo' do
        kudo = Kudo.new(
            sender: sender,
            receiver: receiver,
            category: 'Teamwork',
            message: 'Great job!'
        )
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


    it 'persists a kudo to the database' do
        sender = User.create!(
            username: "sender",
            email: "sender@example.com",
            password: "password123",
            password_confirmation: "password123"
        )

        
        receiver = User.create!(
            username: "receiver",
            email: "receiver@example.com",
            password: "password123",
            password_confirmation: "password123"
        )

        expect {
            Kudo.create!(
            sender: sender,
            receiver: receiver,
            category: 'Leadership',
            message: 'Excellent leadership!'
            )
        }.to change { Kudo.count }.by(1)
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
end
