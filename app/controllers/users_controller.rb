class UsersController < ApplicationController
  def create
    result = Users::Register.call(user_params)

    if result.success?
      redirect_to login_path, notice: "Account created! Please check your email to verify your account."
    else
      flash.now[:alert] = result.error
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
