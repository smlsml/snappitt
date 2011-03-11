class Users::FollowController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :delete]

  def index

  end

  def show
  end

  def create
    @user = User.find(params[:user_id])
    ok = @user.connections_in.create(:from => current_user, :to => @user)
    flash[:success] = "Followed %s" % @user if ok
    redirect_to previous_page || user_follow_index_path(current_user)
  end

  def destroy
    @user = User.find(params[:user_id])
    record = @user.connections_in.find_by_user_id_from(current_user.id)

    if record
      ok = @user.connections_in.delete(record)
      flash[:success] = 'Unfollowed %s' % @user if ok
    end

    redirect_to previous_page || user_follow_index_path(current_user)
  end

end
