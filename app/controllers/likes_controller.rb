class LikesController < ApplicationController
  before_action :require_login
  before_action :set_kudo

  def create
    @like = @kudo.likes.find_or_create_by(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
  end

  def destroy
    @like = @kudo.likes.find_by(user: current_user)
    @like&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:kudo_id])
  end
end
