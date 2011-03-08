class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.save!
  end

  def show
    @user = User.find(params[:id])
    @experiences = Experience.by_user(@user)
  end

end
