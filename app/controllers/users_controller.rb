class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.save!
  end

  def show
    @user = User.find_by_username(params[:id])
  end

end
