class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 15)
  end

  def show
  end

  def new
  end

  def create
  end
end
