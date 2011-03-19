class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  skip_before_filter :verify_authenticity_token

  def new
    @moment = Moment.new
    @moment.caption = CaptionComment.new
    @upload_email = 'post@%s' % t('app.host')
  end

  def edit
    @experience = Experience.find_by_id(params[:id])
    new
    @upload_email = ('exp%s@%s' % [@experience.id, t('app.host')]) if @experience
    render :new
  end

  def create_mail
    @source = Source.find_or_create_from_request(request)

    @message = Mail.new(params[:message])
    return head(:bad_request) unless @message

    logger.warn "Message headers: #{@message.header.field_summary}"

    @to   = params[:to].to_s.downcase.strip
    @from = params[:from].to_s.downcase.strip
    @from = params[:x_sender].to_s.downcase.strip if params[:x_sender]
    @from = params[:x_forwarded_for].to_s.downcase.strip if params[:x_forwarded_for]
    @from = @message.header['Reply-to'].addresses.first.to_s.downcase if @message.header['Reply-to']

    @user = User.find_by_email(@from)

    if !@user
      password = User.generate_password
      logger.info "Creating a new user: #{@from}"
      username = @from.to_s.downcase.strip.split('@')[0]
      username = username << Time.now().to_i.to_s if User.find_by_username(username)

      @user = User.new(:email => @from,
                       :password => password,
                       :password_confirmation => password,
                       :username => username)

      @user.force_reset = 1 # not working in .new, wtf?
      @user.save!
    end

    return head(:unauthorized) unless @user

    @subject = params[:subject].to_s.strip
    while @subject.gsub!(/^re:/i,''); @subject.strip!; end
    while @subject.gsub!(/^fwd:/i,''); @subject.strip!; end

    @experience = Experience.find_by_id($1) if @to =~ /exp([0-9]+)@/i
    @experience = Experience.where(:creator => @user, :title => @subject).order('created_at DESC').first unless @experience
    @experience = Experience.new(:title => @subject) unless @experience
    @experience.visibility = 'private' if params[:to].to_s.downcase.include?('private')

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
    return render :private if @experience.private? && !can_edit?(@experience.creator)
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

  def destroy
    @experience = Experience.find_by_id(params[:id])
    @experience.destroy if @experience

    flash[:success] = "Deleted Experience: #{@experience}" if @experience
    redirect_to root_url
  end

end
