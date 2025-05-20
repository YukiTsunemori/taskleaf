class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  private
    # controller内に定義するpublicなメソッドはルーティングが通っていればアクションとして呼び出される可能性がある。
    # データー取得のためのユーティリティメソッドはprivateにすべきである。
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
end
