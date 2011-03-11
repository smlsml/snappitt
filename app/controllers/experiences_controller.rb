class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @moment = Moment.new
    @moment.caption = CaptionComment.new
  end

  def show
    @experience = Experience.find(params[:id])
    @experience.increment!(:views, 1) unless is_bot?
  end

  def create
    @moment = Moment.create(params[:moment])
    @source = Source.find_or_create_from_request(request)

    @moment.creator = current_user
    @moment.thing = Thing.find_or_create_by_name(params[:thing]) if params[:thing]
    @moment.location = Location.find_or_create_by_name(params[:location]) if params[:location]
    @moment.source = @source
    @moment.caption.creator = current_user

    if params[:asset]
      @asset = PhotoAsset.new(params[:asset])
      @asset.creator = current_user
      @asset.source = @source

      @moment.asset = @asset
    end

    if params[:add_moment]
      @experience = Experience.find(params[:last_moment])
    else
      @experience = Experience.new(:title => '%s @ %s' % [@moment.thing.name, @moment.location.name])
    end

    @moment.experience = @experience
    @moment.experience.creator = current_user

    if @moment.save
      flash[:success] = "Experience Created!"
      redirect_to experience_path(@experience)
    else
      flash.now[:error] = "Error!"
    end

#    params[:people].to_a.compact.uniq.each do |p|
#      c = Contact.create(:name => p[:tag])
#    end

  end

end
