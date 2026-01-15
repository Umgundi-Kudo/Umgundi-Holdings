class DashboardController < ApplicationController
  before_action :require_login

  def index
    # Feed: all kudos (reverse chronological)
    @kudos = Kudo
      .includes(:sender, :receiver)
      .order(created_at: :desc)

    # Profile: kudos received by current user
    @received_kudos = current_user
      .received_kudos
      .includes(:sender)
      .order(created_at: :desc)
  end
end
