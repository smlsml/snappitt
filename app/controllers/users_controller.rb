class UsersController < ApplicationController

  def index
    @user = current_user
  end

  def show
    @nav_location = "profile"
    @user = User.find(params[:id])
    @experiences = Experience.by_user(@user)
  end

end