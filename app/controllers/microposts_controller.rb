class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash[:success] = "メッセージを投稿しました。"
      redirect_to root_url
    else
      @pagy, @microposts = pagy(current_user.feed_microposts.order(id: :desc)) #toppages/indexはアクションの処理をせずにtoppage.html.erbを返すだけのためインスタンスが必要
      flash.now[:danger] = "メッセージの投稿に失敗しました。"
      render "toppages/index", status: :unprocessable_entity #status: :unprocessable_entity rails7.0以降追記が必要
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: root_path) #アクションが実行されたページに戻るメソッド
  end
  
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost #nil, falseの時に実行される
      redirect_to root_url
    end
  end
end
