class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @moment = Moment.new
    @moment.caption = CaptionComment.new
  end

  def create_mail
    #Rails.logger.log('Received experience email...')
    #Rails.logger.log('- plain: %s' % params[:plain].to_s)
    #Rails.logger.log('- from: %s' % params[:from].to_s)
    #Rails.logger.log('- subject: %s' % params[:subject].to_s)
    #Rails.logger.log('- attachments: %s' % params[:attachments].inspect.to_s)

    @user = User.find_by_email(params[:from])
    @asset = PhotoAsset.from_url(params[:attachments]['0'][:url])

    create
  end

  def show
    @experience = Experience.find(params[:id])
    @experience.increment!(:views, 1) unless is_bot?
  end

  def create
    @user = current_user unless @user

    @moment = Moment.create(params[:moment])
    @source = Source.find_or_create_from_request(request)

    @moment.creator = @user
    @moment.thing = Thing.find_or_create_by_name(params[:thing]) if params[:thing]
    @moment.location = Location.find_or_create_by_name(params[:location]) if params[:location]
    @moment.source = @source
    @moment.caption.creator = @user

    if params[:asset]
      @asset = PhotoAsset.new(params[:asset])
    end

    if @asset
      @asset.creator = @user
      @asset.source = @source

      @moment.asset = @asset
    end

    if params[:add_moment]
      @experience = Experience.find(params[:last_moment])
    else
      @experience = Experience.new(:title => '%s @ %s' % [@moment.thing.name, @moment.location.name])
    end

    @moment.experience = @experience
    @moment.experience.creator = @user

    if @moment.save
      flash[:success] = "Experience Created!"
      redirect_to experience_path(@experience)
    else
      flash.now[:error] = "Error!"
      render :create
    end

#    params[:people].to_a.compact.uniq.each do |p|
#      c = Contact.create(:name => p[:tag])
#    end

  end

end
