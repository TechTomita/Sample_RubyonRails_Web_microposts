class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    fav_post = Micropost.find(params[:post_id])
    
    current_user.favorite(fav_post)
    flash[:success] = "お気に入り登録しました。"
    redirect_to root_path #likes_pathに変更する
  end

  def destroy
  end
end
