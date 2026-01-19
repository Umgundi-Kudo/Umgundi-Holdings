require "rails_helper"

RSpec.describe Kudos::KudoCreate do
  let(:sender) do
    create(
      :user,
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:receiver) do
    create(
      :user,
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let(:valid_params) do
    {
      receiver_id: receiver.id,
      category: Kudo::CATEGORIES.first,
      message: "Great job!"
    }
  end

  describe ".call" do
    context "with valid params" do
      it "creates a kudo" do
        expect {
          result = described_class.call(
            sender: sender,
            params: valid_params
          )

          expect(result.success?).to be true
        }.to change(Kudo, :count).by(1)
      end

      it "assigns the sender correctly" do
        result = described_class.call(
          sender: sender,
          params: valid_params
        )

        expect(result.kudo.sender).to eq(sender)
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          receiver_id: receiver.id,
          category: "",
          message: ""
        }
      end

      it "does not create a kudo" do
        expect {
          result = described_class.call(
            sender: sender,
            params: invalid_params
          )

          expect(result.success?).to be false
        }.not_to change(Kudo, :count)
      end
    end
  end
end
