class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = "ログインに成功しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました。"
      render :new, status: :unprocessable_entity #status: :unprocessable_entity rails7.0以降追記が必要
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  
  private
  
  # ログイン処理
  def login(email, password)
    @user = User.find_by(email: email)
    
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
