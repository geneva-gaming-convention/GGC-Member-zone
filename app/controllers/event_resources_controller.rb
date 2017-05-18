class EventResourcesController < ApplicationController

  def index
    @event_resources = EventResource.where(event_id: params["event_id"])
    if @event_resources
      render 'index', :layout => false
    else
      render_404
    end
  end

  def show
    @event_resource = EventResource.find_by(event_id: params["event_id"], id: params["id"])
    if !@event_resource
      render_404
    end
  end

  def get_teams
    @event_resource = EventResource.find_by(id: params["event_resource_id"], event_id: params["event_id"])
    if @event_resource
      @teams = @event_resource.get_teams
      render 'teams', :layout => false
    else
      render_404
    end
  end

  def get_teams_and_players
    @event_resource = EventResource.find_by(id: params["event_resource_id"], event_id: params["event_id"])
    if @event_resource
      @teams = @event_resource.get_teams_with_members
      render 'teams', :layout => false
    else
      render_404
    end
  end
end
