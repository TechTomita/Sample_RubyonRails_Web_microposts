class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    fav_post = Micropost.find(params[:post_id])
    
    current_user.favorite(fav_post)
    flash[:success] = "お気に入り登録しました。"
    redirect_to likes_user_url(current_user)
  end

  def destroy
    fav_post = Micropost.find(params[:post_id])
    
    current_user.unfavorite(fav_post)
    flash[:danger] = "お気に入りを解除しました。"
    redirect_to likes_user_url(current_user)
  end
end
