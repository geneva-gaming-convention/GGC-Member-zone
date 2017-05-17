class EventsController < ApplicationController
  #before_action :must_be_logged
  #before_action :must_be_ready_to_registration, only: [:show]

  def index
    @events = Event.all.where(visible: true)
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
