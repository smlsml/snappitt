class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:home]

  def index
    return(self.home) if user_signed_in?
    welcome
  end

  def home
    @experiences = Experience.user_feed(current_user).limit(30)
    render :home
  end

  def welcome
    @welcome = true
    render :welcome
  end

end