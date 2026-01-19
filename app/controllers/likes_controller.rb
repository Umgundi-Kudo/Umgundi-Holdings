class LikesController < ApplicationController
  before_action :require_login

  def create
    @kudo = Kudo.find(params[:kudo_id])
    @like = @kudo.likes.create(user: current_user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
  end

  def destroy
    @kudo = Kudo.find(params[:kudo_id])
    @like = @kudo.likes.find_by(user: current_user)
    @like&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dashboard_path }
    end
  end
end
