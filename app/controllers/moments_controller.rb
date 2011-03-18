class MomentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:like, :comment]

  def show
  end

  def like
    @user = current_user
    @moment = Moment.find(params[:id])

    Like.create!(:user_id => @user.id, :moment_id => @moment.id)

    flash[:success] = 'Liked Moment'

    redirect_to experience_path(@moment.experience)
  end

  def comment
    @user = current_user
    @moment = Moment.find(params[:id])

    MomentComment.create(:user_id => @user.id, :moment_id => @moment.id, :text => params[:comment].to_s.strip)

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