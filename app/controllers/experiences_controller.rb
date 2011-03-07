class ExperiencesController < ApplicationController

  def new
    @moment = Moment.new
    @moment.comment = Comment.new
    @moment.experience = Experience.new
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def create
    @moment = Moment.create(params[:moment])

    @moment.creator = current_user
    @moment.thing = Thing.find_or_create_by_name(params[:thing]) if params[:thing]
    @moment.location = Location.find_or_create_by_name(params[:location]) if params[:location]
    @moment.experience.creator = current_user

    if @moment.save
      flash[:success] = "Created experience!"
    else
      flash[:error] = "Error!"
    end

#    params[:people].to_a.compact.uniq.each do |p|
#      c = Contact.create(:name => p[:tag])
#    end

  end

end
