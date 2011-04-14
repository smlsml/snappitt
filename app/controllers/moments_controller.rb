class MomentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:like, :comment]

  def show
  end

  def publish
    @user = current_user
    @moment = Moment.find(params[:id])

    PublishFlag.create!(:user => @user, :moment => @moment)

    flash[:success] = 'Published Moment'

    redirect_to experience_path(@moment.experience, :anchor => @moment.id)
  end

  def like
    @user = current_user
    @moment = Moment.find(params[:id])

    if params[:shot] && LikeFlag::SHOTS.include?(params[:shot])
      flag = @moment.likes.by_user(@user).first
      flag = LikeFlag.create(:user => @user, :moment => @moment) unless flag
      flag.shot = params[:shot]
      flag.save!
      flash[:success] = 'Classified Moment'
    end

    respond_to do |format|
      format.js { head(:ok) }
      format.html { experience_path(@moment.experience, :anchor => @moment.id) }
    end
  end

  def comment
    @user = current_user
    @moment = Moment.find(params[:id])

    MomentComment.create!(:user => @user, :moment => @moment, :text => params[:comment].to_s.strip)

    flash[:success] = 'Added comment'

    redirect_to experience_path(@moment.experience, :anchor => @moment.id)
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