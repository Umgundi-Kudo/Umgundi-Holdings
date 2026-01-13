class SessionsController < ApplicationController
  def new
    # renders the login form
  end

  def create
    user = Sessions::Authenticate.call(
      email: params[:email],
      password: params[:password]
    )

    unless user
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
      return
    end

    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
