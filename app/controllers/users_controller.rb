class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  before_action :find_user, only: [:show, :followings, :followers]
  before_action :count_user, only: [:show, :followings, :followers]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 15)
  end

  def show
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new, status: :unprocessable_entity #status: :unprocessable_entity rails7.0以降追記が必要
    end
  end
  
  def followings
    @pagy, @followings = pagy(@user.followings)
  end
    
  def followers
    @pagy, @followers = pagy(@user.followers)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def count_user
    counts(@user)
  end
end
