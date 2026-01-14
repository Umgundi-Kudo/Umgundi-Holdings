class DashboardController < ApplicationController
  before_action :require_login

  def index
    @kudos = Kudo
    .includes(:sender, :receiver)
    .oorder(created_at: :desc)
  end 
end
