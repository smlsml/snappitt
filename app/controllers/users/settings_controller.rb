class Users::SettingsController < ApplicationController

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

    if @profile.update_attributes!(params[:profile])
      flash[:success] = 'Updated Profile'
    else
      flash[:error] = 'Error'
    end

    redirect_to user_settings_path
  end

end
