class LeaderboardController < ApplicationController
  before_action :require_login

  def index
    @leaders = User
      .joins(:received_kudos)
      .where("kudos.created_at >= ?", 30.days.ago)
      .group("users.id")
      .order("COUNT(kudos.id) DESC")
      .select("users.*, COUNT(kudos.id) AS kudos_count")
  end
end
