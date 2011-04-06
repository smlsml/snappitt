class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      flash[:success] = "Event Created"
    else
      flash.now[:error] = "Error %s" % @event.errors.full_messages.to_sentence
      render :new
    end
  end

end
