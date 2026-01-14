class KudosController < ApplicationController
  before_action :require_login

  def new
    @kudo = Kudo.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    result = Kudos::KudoCreate.call(sender: current_user, params: kudo_params)
    if result.success?
      redirect_to dashboard_path, notice: "Kudo sent 🎉"
    else
      @kudo = result.kudo
      @users = User.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def kudo_params
    params.require(:kudo).permit(:receiver_id, :category, :message)
  end
end
