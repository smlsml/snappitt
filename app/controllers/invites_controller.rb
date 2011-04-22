class InvitesController < ApplicationController

  def new
    @user = current_user
    @experience = Experience.find_by_id(params[:experience])
    @invite = Invite.new
  end

  def create
    new
    str = params[:contact].fetch(:data, "").to_s.strip.gsub(' ',',')
    @parts = str.split(',').collect{|p| p.to_s.strip.downcase}.compact.uniq.reject{|p| p.blank?}

    @users = []
    @emails = []

    @parts.each do |p|
      user = User.where({:username => p} | {:email => p})

      if !user.blank?
        @users += user
      elsif p.is_email?
        @emails << p.strip
      end
    end

    @users = @users.flatten.compact.uniq
  end

end
