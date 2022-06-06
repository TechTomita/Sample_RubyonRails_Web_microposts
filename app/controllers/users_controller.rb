class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 15)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
  end
end
