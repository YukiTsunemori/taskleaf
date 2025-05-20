class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
