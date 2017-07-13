class EventsController < ApplicationController
  #before_action :must_be_logged
  #before_action :must_be_ready_to_registration, only: [:show]

  def index
    @events = Event.all.where("visible = ? and end_date > ?", true, DateTime.now)
    @title = "upcoming event"
  end

  def archived
    @events = Event.all.where("end_date < ?",  DateTime.now)
    @title = "archived event"
    render 'index'
  end

  def show
    @event = Event.find_by(id: params["id"])
    if !@event
      render_404
    else
      @event_resources = @event.event_resources
    end
  end

  def events_params
    params.require(:event).permit(:name, :shortname)
  end
end
