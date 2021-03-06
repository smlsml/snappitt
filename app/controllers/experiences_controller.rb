class ExperiencesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  before_filter :must_be_owner, :only => [:edit, :update]
  skip_before_filter :verify_authenticity_token

  def new
    @moment = Moment.new
    @moment.caption = CaptionComment.new
    @upload_email = t('email.post')
  end

  def edit
    @experience = Experience.find_by_id(params[:id])
  end

  def update
    @experience = Experience.find_by_id(params[:id])
    flash[:success] = "Updated" if @experience.update_attributes(params[:experience])
    redirect_to experience_path(@experience)
  end

  def add
    @experience = Experience.find_by_id(params[:id])
    new
    @upload_email = @experience.upload_email if @experience
    render :new
  end

  def create_mail
    @message = Mail.new(params[:message])
    return head(:bad_request) unless @message

    @to   = params[:to].to_s.downcase.gsub('<','').gsub('>','').strip
    @from = params[:from].to_s.downcase.strip
    @from = params[:x_sender].to_s.downcase.strip if params[:x_sender]
    @from = params[:x_forwarded_for].to_s.downcase.strip if params[:x_forwarded_for]
    @from = @message.header['Reply-to'].addresses.first.to_s.downcase if @message.header['Reply-to']

    @subject = params[:subject].to_s.strip
    while @subject.gsub!(/^re:/i,''); @subject.strip!; end
    while @subject.gsub!(/^fwd:/i,''); @subject.strip!; end

    @user = User.find_by_email(@from)
    @user = User.create_from_email(@from) unless @user

    return head(:unauthorized) unless @user
    return head(:forbidden) if @user.disabled

    @source = Source.find_or_create_from_request(request)

    if @to.match(t('email.avatar')) || @to.match(t('email.profile'))
      @user.profile.set_avatar_from_email_attachment(@message.attachments.first, @source)
      @user.profile.update_attribute(:bio, @subject) if @subject

      return head(:created)
    end

    @experience = Experience.find_by_id($1) if @to =~ /post([0-9]+)@/i

    unless @experience
      if @to =~ /(.*?)@/i
        @event = Event.find_by_hashtag($1.to_s.downcase.strip)
        if @event
          @event.create_experience(:title => @event.name, :user => @user) unless @event.experience
          @event.save!
          @experience = @event.experience
        end
      end

      @experience = Experience.new(:title => @subject, :user => @user) unless @experience
    end

    @experience.visibility = 'private' if params[:to].to_s.downcase.include?('private')

    if params[:attachments]
      params[:attachments].each do |index, attachment|
        moment = Moment.new(:user => @user, :source => @source)
        moment.build_caption(:text => @subject, :user => @user)

        type = PhotoAsset
        type = VideoAsset if attachment[:content_type].to_s.starts_with?('video')
        moment.asset = type.create(:user => @user, :source => @source, :tmp_url => attachment[:url])

        @experience.moments << moment
      end
    end

    @message.attachments.each do |attachment|
      moment = Moment.new(:user => @user, :source => @source)
      moment.create_caption(:text => @subject, :user => @user)

      file = StringIO.new(attachment.decoded)
      file.class.class_eval { attr_accessor :original_filename, :content_type }
      file.original_filename = attachment.filename
      file.content_type = attachment.mime_type

      asset = PhotoAsset.create(:user => @user, :source => @source, :data => file)
      moment.asset = asset if asset

      unless @user.profile.has_photo?
        @user.profile.photo_asset = asset
        @user.profile.save
      end

      @experience.moments << moment
    end

    @experience.save!
    ExperienceMailer.upload_notification(@experience, @user).deliver rescue nil

    head(:created)
  end

  def show
    @experience = Experience.find(params[:id])
    return render :private if @experience.private? && !can_edit?(@experience.user)

    unless @experience.user.confirmed?
      return render :confirm unless can_edit?(@experience.user)
      flash.now[:notice] = 'You must confirm your account before others can view your experiences'
    end

    @causes = Cause.reject_deleted(Cause.for_experience(@experience).limit(20))
    @fbmeta = FbMeta.new(:title => @experience.title, :image => @experience.photo_url(:avatar), :url => experience_url(@experience))

    @experience.increment!(:views, 1) unless is_bot?

    @view = params[:all] ? 'all' : 'grid'
  end

  def create
    if create_moment
      flash[:success] = "Experience Created!"
      redirect_to experience_path(@experience)
    else
      flash.now[:error] = "Error!"
      render :create
    end
  end

  def create_moment
    @user = current_user unless @user

    if params[:moment]
      @moment = Moment.new(params[:moment])
    end

    @source = Source.find_or_create_from_request(request)

    return head :bad_request unless @moment

    @moment.user = @user
    @moment.thing = Thing.find_or_create_by_name(params[:thing]) if params[:thing]
    @moment.location = Location.find_or_create_by_name(params[:location]) if params[:location]
    @moment.source = @source
    @moment.caption.user = @user

    if params[:asset]
      @asset = PhotoAsset.new(params[:asset])
    end

    if @asset
      @asset.user = @user
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
        @experience.user = @user
      else
        @experience = Experience.new(:title => "Untitled")
        @experience.user = @user
      end
    end

    @moment.experience = @experience

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
