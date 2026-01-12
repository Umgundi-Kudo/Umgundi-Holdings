class EmailVerificationsController < ApplicationController
  def update
    result = Users::VerifyEmail.call(params[:token])

    if result.success?
      redirect_to login_path, notice: "Email verified. You can now log in."
    else
      redirect_to login_path, alert: result.error
    end
  end
end
