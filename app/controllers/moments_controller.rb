class MomentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:like, :comment]

  def show
  end

  def publish
    @user = current_user
    @moment = Moment.find(params[:id])

    PublishFlag.create!(:user => @user, :moment => @moment)

    flash[:success] = 'Published Moment'

    redirect_to experience_path(@moment.experience)
  end

  def like
    @user = current_user
    @moment = Moment.find(params[:id])

    LikeFlag.create!(:user => @user, :moment => @moment)

    flash[:success] = 'Liked Moment'

    redirect_to experience_path(@moment.experience)
  end

  def comment
    @user = current_user
    @moment = Moment.find(params[:id])

    MomentComment.create!(:user => @user, :moment => @moment, :text => params[:comment].to_s.strip)

    flash[:success] = 'Added comment'

    redirect_to experience_path(@moment.experience)
  end

  def destroy
    @user = current_user
    @moment = Moment.find(params[:id])

    @moment.destroy if @moment
    flash[:success] = "Deleted Moment: #{@moment}" if @moment

    url = experience_path(@moment.experience) if @moment && @moment.experience

    redirect_to previous_page || url || root_path
  end

end