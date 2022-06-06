class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash[:success] = "メッセージを投稿しました。"
      redirect_to root_url
    else
      @pagy, @microposts = pagy(current_user.microposts.order(id: :desc)) #toppages/indexはアクションの処理をせずにtoppage.html.erbを返すだけのためインスタンスが必要
      flash.now[:danger] = "メッセージの投稿に失敗しました。"
      render "toppages/index", status: :unprocessable_entity #status: :unprocessable_entity rails7.0以降追記が必要
    end
  end

  def destroy
  end
  
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
