class KudosController < ApplicationController
  before_action :require_login

  def new
    @kudo = Kudo.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.sender = current_user

    if @kudo.save
      redirect_to dashboard_path, notice: "Kudo sent 🎉"
    else
      flash.now[:alert] = "Please fix the errors below"
      @users = User.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def kudo_params
    params.require(:kudo).permit(:receiver_id, :category, :message)
  end
end
