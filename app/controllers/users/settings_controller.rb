class Users::SettingsController < ApplicationController
  skip_before_filter :force_reset
  before_filter :authenticate_user!

  def show
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if params[:asset]
      @source = Source.find_or_create_from_request(request)
      @asset = PhotoAsset.new(params[:asset])
      @asset.creator = current_user
      @asset.source = @source

      @profile.photo_asset = @asset
    end

    if params[:password] && !params[:password][:new].blank?
      if current_user.reset_password!(params[:password][:new], params[:password][:confirm])
        current_user.update_attribute(:force_reset, 0)
        pw = ' and password at %s' % Time.now
      else
        flash[:error] = "Error updating password: #{current_user.errors}"
      end
    end

    if @profile.update_attributes!(params[:profile])
      flash[:success] = 'Updated Profile%s' % pw
    else
      flash[:error] = 'Error updating profile: %s' % @profile.errors
    end

    redirect_to user_settings_path
  end

end
