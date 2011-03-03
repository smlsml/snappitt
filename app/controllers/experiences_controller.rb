class ExperiencesController < ApplicationController

  def new
    @experience = Experience.new
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def create
    @experience = Experience.new(params[:experience])
  end

end
