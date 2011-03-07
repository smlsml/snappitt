class HomeController < ApplicationController
  helper :home

  def index
    return(self.home) if user_signed_in?
    welcome
  end

  def home
    @feed = Experience.user_feed(current_user)
    render :home
  end

  def welcome
    render :welcome
  end

end