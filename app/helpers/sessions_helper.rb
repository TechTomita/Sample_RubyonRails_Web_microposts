module SessionsHelper
    # 現在ログインしているユーザを取得
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # ログインしているか確認
    def logged_in?
        !!current_user
    end
end
