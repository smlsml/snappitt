class Users::SettingsController < ApplicationController
  skip_before_filter :force_reset
  before_filter :authenticate_user!

  def show
    @profile = current_user.profile
    @user_username = User.find(current_user.id)
    @user_email    = User.find(current_user.id)
    @user_password = User.find(current_user.id)
  end

  def update
    success = ""
    error = ""

    show # get instance variables

    if params[:user] && params[:user][:username] && @user_username.username != params[:user][:username]
      @user_username.username = params[:user][:username]
      if @user_username.save
        success << ' and changed username'
      else
        error << ' ' << @user_username.errors.full_messages.to_s
      end
    end

    if params[:user] && params[:user][:email] && @user_email.email != params[:user][:email]
      @user_email.email = params[:user][:email]
      if @user_email.save
        @user_email.send_confirmation_instructions
        success << ' and changed email'
      else
        error << ' ' << @user_email.errors.full_messages.to_s
      end
    end

    if params[:profile_photo]
      @source = Source.find_or_create_from_request(request)
      @asset = PhotoAsset.new(params[:profile_photo])
      @asset.user = current_user
      @asset.source = @source

      @profile.photo_asset = @asset
      success << ' and profile photo'
    end

    if params[:password] && !params[:password][:new].blank?
      if @user_password.reset_password!(params[:password][:new], params[:password][:confirm])
        @user_password.update_attribute(:force_reset, 0)
        sign_in @user_password, :bypass => true
        success << ' and password'
      else
        error << ' ' << @user_password.errors.full_messages.to_s
      end
    end

    if params[:hometown] && params[:hometown][:name]
      @hometown = Location.find_or_create_by_name(params[:hometown][:name].to_s.strip)
      original = @profile.hometown
      @profile.hometown = @hometown if @hometown
      success << ' and hometown' unless original == @hometown
    end

    if params[:dont_notify_for]
      before = @profile.dont_notify_for
      @profile.dont_notify_for = params[:dont_notify_for].values.reject{|v| v.blank?}.uniq.compact.join(',')
      success << ' and updated email notifications' if before != @profile.dont_notify_for
    end

    if @profile.update_attributes!(params[:profile])
      flash.now[:success] = 'Saved profile%s' % success
    else
      error << @profile.errors.full_messages.to_s
    end

    unless error.blank?
      flash.now[:error]= 'Some fields not changed:%s' % error
    end

    render :show
  end

end
