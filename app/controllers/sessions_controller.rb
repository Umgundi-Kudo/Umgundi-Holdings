class SessionsController < ApplicationController
  def create
    result = Sessions::Authenticate.call(
      email: params[:email],
      password: params[:password]
    )

    if result.success?
      session[:user_id] = result.user.id
      redirect_to dashboard_path
    else
      flash.now[:alert] = result.error
      render :new, status: :unprocessable_entity
    end
  end
end
