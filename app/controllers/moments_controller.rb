class MomentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:like]

  def show
  end

  def like
    @user = current_user
    @moment = Moment.find(params[:id])

    Like.create!(:user_id => @user.id, :moment_id => @moment.id)

    flash[:success] = 'Liked Moment'

    redirect_to experience_path(@moment.experience)
  end

end
