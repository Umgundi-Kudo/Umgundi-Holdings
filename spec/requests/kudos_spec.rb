require "rails_helper"

RSpec.describe "Kudos", type: :request do
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

  before do
    # log in the sender
    post login_path, params: {
      email: sender.email,
      password: "password123"
    }
  end

  describe "GET /kudos/new" do
    context "when logged in" do
      it "returns http success" do
        get new_kudo_path
        expect(response).to have_http_status(:ok)
      end

      it "renders the new template" do
        get new_kudo_path
        expect(response.body).to include("Send a Kudo")
      end
    end
  end

  describe "POST /kudos" do
    context "with valid params" do
      let(:valid_params) do
        {
          kudo: {
            receiver_id: receiver.id,
            category: Kudo::CATEGORIES.first,
            message: "Amazing teamwork!"
          }
        }
      end

      it "creates a new kudo" do
        expect {
          post kudos_path, params: valid_params
        }.to change(Kudo, :count).by(1)
      end

      it "assigns the current user as sender" do
        post kudos_path, params: valid_params
        expect(Kudo.last.sender).to eq(sender)
      end

      it "redirects to dashboard with success notice" do
        post kudos_path, params: valid_params
        expect(response).to redirect_to(dashboard_path)
        follow_redirect!
        expect(response.body).to include("Kudo sent")
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          kudo: {
            receiver_id: receiver.id,
            category: "",
            message: ""
          }
        }
      end

      it "does not create a kudo" do
        expect {
          post kudos_path, params: invalid_params
        }.not_to change(Kudo, :count)
      end

      it "re-renders the form with unprocessable_entity status" do
        post kudos_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Send a Kudo")
        expect(response.body).to include("Please fix the errors")
      end
    end
  end
end
