class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  skip_before_filter :verify_authenticity_token

  def new
    @moment = Moment.new
    @moment.caption = CaptionComment.new
  end

  def create_mail
    @source = Source.find_or_create_from_request(request)

    @from = params[:from].to_s.downcase.strip
    @user = User.find_by_email(@from)

    if !@user
      password = User.generate_password
      logger.info "Creating a new user: #{@from}"
      username = @from.to_s.downcase.strip.split('@')[0]
      username = username << Time.now().to_i.to_s if User.find_by_username(username)

      @user = User.create!(:email => @from,
                           :password => password,
                           :password_confirmation => password,
                           :username => username)
    end

    return head(:unauthorized) unless @user

    @experience = Experience.where(:creator => @user, :title => params[:subject]).order('created_at DESC').first
    @experience = Experience.new(:title => params[:subject]) unless @experience
    @experience.visibility = 'group' if params[:to].to_s.downcase.include?('group')

    @message = Mail.new(params[:message])

    return head(:bad_request) unless @message

    logger.warn "Message headers: #{@message.header.field_summary}"
    @message.attachments.each do |attachment|
      moment = Moment.new
      moment.create_caption(:text => params[:plain])
      moment.creator = @user
      moment.source = @source

      file = StringIO.new(attachment.decoded)
      file.class.class_eval { attr_accessor :original_filename, :content_type }
      file.original_filename = attachment.filename
      file.content_type = attachment.mime_type

      asset = PhotoAsset.new(:data => file)

      if asset
        asset.creator = @user
        asset.source = @source
        moment.asset = asset
      end

      @experience.moments << moment
    end

    @experience.creator = @user
    @experience.save!
    ExperienceMailer.upload_notification(@experience).deliver

    head(:created)
  end

  def show
    @experience = Experience.find(params[:id])
    @experience.increment!(:views, 1) unless is_bot?
  end

  def create
    if create_moment
      flash[:success] = "Experience Created!"
      redirect_to experience_path(@experience)
    else
      flash.now[:error] = "Error!"
      Rails.logger.info('error creating moment')
      render :create
    end
  end

  def create_moment
    @user = current_user unless @user

    if params[:moment]
      @moment = Moment.create(params[:moment])
    end

    @source = Source.find_or_create_from_request(request)

    return head :bad_request unless @moment

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

    unless @experience
      if params[:add_moment]
        @experience = Experience.find(params[:last_moment])
      elsif params[:add_grp_moment]
        @experience = Experience.find(params[:grp_moment])
      elsif @moment.thing && @moment.location
        @experience = Experience.new(:title => '%s @ %s' % [@moment.thing, @moment.location])
      else
        @experience = Experience.new(:title => "none")
      end
    end

    @moment.experience = @experience
    @moment.experience.creator = @user

    return @moment.save

#    params[:people].to_a.compact.uniq.each do |p|
#      c = Contact.create(:name => p[:tag])
#    end

  end

end
