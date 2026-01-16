class LeaderboardController < ApplicationController
  before_action :require_login

  def index
    @leaders = User
      .joins(:received_kudos)
      .group("users.id")
      .order("COUNT(kudos.id) DESC")
      .select("users.*, COUNT(kudos.id) AS kudos_count")
  end
end
