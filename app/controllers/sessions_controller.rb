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

  def destroy
    reset_session
    # reset_sessionを使う理由は、ユーザーに紐づくその他の情報をセッションに入れるようにしている場合は、
    # ログアウト時にデータ全てを消したいかもしれません。その時に使うメソッド。
    # session.delete(:user_id)だけでは、user_idがnilになるだけ
    flash[:success] = "ログアウトに成功しました"
    redirect_to root_url
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
