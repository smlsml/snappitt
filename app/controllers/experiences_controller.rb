class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  skip_before_filter :verify_authenticity_token

  def new
    @moment = Moment.new
    @moment.caption = CaptionComment.new
  end

  def create_mail
    message = Mail.new(params[:message])
    attachment = message.attachments.first

    file = StringIO.new(attachment.decoded)
    file.class.class_eval { attr_accessor :original_filename, :content_type }
    file.original_filename = attachment.filename
    file.content_type = attachment.mime_type

    @user = User.find_by_email(params[:from])
    Rails.logger.info('User is %s' % @user)
    params[:moment] = {:caption => params[:plain]}

    @asset = PhotoAsset.new(:data => file)

    #@asset = PhotoAsset.from_url(AWS::S3::S3Object.url_for(params[:attachments]['0'][:file_name], 'snappitt2'))

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
      Rails.logger.info('error creating moment')
      render :create
    end

#    params[:people].to_a.compact.uniq.each do |p|
#      c = Contact.create(:name => p[:tag])
#    end

  end

end
