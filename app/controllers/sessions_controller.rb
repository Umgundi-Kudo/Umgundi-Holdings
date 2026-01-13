class SessionsController < ApplicationController
  def new
    # renders the login form
  end

  def create
    user = Sessions::Authenticate.call(
      username: params[:username],
      password: params[:password]
    )

    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Invalid username or password"
      render :new, status: :unprocessable_entity
    end
  end
end
