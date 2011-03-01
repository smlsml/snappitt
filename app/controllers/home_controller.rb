class HomeController < ApplicationController
  helper :home

  def index
    return self.welcome
  end

  def home
  end

  def welcome
    render :welcome
  end

end