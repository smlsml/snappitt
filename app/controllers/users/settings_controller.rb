class Users::SettingsController < ApplicationController
  skip_before_filter :force_reset
  before_filter :authenticate_user!

  def show
    @profile = current_user.profile
  end

  def update
    success = ""

    @profile = current_user.profile

    if params[:profile_photo]
      @source = Source.find_or_create_from_request(request)
      @asset = PhotoAsset.new(params[:profile_photo])
      @asset.user = current_user
      @asset.source = @source

      @profile.photo_asset = @asset
      success << ' and profile photo'
    end

    if params[:password] && !params[:password][:new].blank?
      if current_user.reset_password!(params[:password][:new], params[:password][:confirm])
        current_user.update_attribute(:force_reset, 0)
        success << ' and password'
      else
        flash[:error] = "Error updating password: #{current_user.errors}"
      end
    end

    if params[:hometown] && params[:hometown][:name]
      @hometown = Location.find_or_create_by_name(params[:hometown][:name].to_s.strip)
      original = @profile.hometown
      @profile.hometown = @hometown if @hometown
      success << ' and hometown' unless original == @hometown
    end

    if @profile.update_attributes!(params[:profile])
      flash[:success] = 'Saved profile%s' % success
    else
      flash[:error] = 'Error updating profile: %s' % @profile.errors
    end

    redirect_to user_settings_path
  end

end
