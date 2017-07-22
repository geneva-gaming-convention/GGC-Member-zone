class RegistrationsController < ApplicationController
  before_action :must_be_logged
  before_action :event_must_exist,                      only: [:create, :is_still_free_slots]
  before_action :event_resource_must_exist,             only: [:create, :is_still_free_slots]
  before_action :event_pack_must_exist,                 only: [:create]

  def index

  end

  def create
    #Parameters: {"event_resource_id"=>"6", "registration_pack"=>"3", "registration_team"=>"13", "is_manager"=>"true", "event_id"=>"2"}
    #<Registration id: nil, user_id: nil, event_id: nil, created_at: nil, updated_at: nil, event_resource_id: nil, event_pack_id: nil, team_id: nil>
    registration = Registration.new
    registration.user = current_logged_user
    registration.is_a_player = true
    registration.event = @event
    registration.event_resource = @event_resource
    registration.event_pack = @event_pack
    if @event_resource.game && @event_resource.game.teambased && params.has_key?(:registration_team)
      registration.team = Team.find_by(id: params[:registration_team])
      registration.users_group = registration.team.users_group
    end
    if !@event_resource.game
      registration.is_a_player = false
    end

    if params.has_key?(:registration_group)
      users_group = UsersGroup.find_by(id: params[:registration_group])
      if users_group
        registration.users_group = users_group
      end
    end

    if registration.save
      begin
        customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
        )
        charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => registration.event_pack.price.to_i*100,
        :description => registration.user.name+" "+registration.user.lastname+" "+registration.event_pack.name,
        :currency    => 'chf'
        )
      rescue Stripe::CardError => e
        registration.destroy
        flash[:danger] = e.message
        redirect_to event_event_resource_path(@event, @event_resource)
      end
      flash[:success] = "You're registered"
      redirect_to event_event_resource_path(@event, @event_resource)
    else
      flash[:danger] = "An error occurred while registering, "+registration.errors.full_messages.to_sentence+"."
      redirect_to event_event_resource_path(@event, @event_resource)
    end
  end

  def event_must_exist
    @event = Event.find_by(id: params[:event_id])
    if !@event
      render_404
    end
  end

  def event_resource_must_exist
    @event_resource = EventResource.find_by(id: params[:event_resource_id])
    if !@event_resource
      render_404
    end
  end

  def event_pack_must_exist
    if params[:registration_pack]
      @event_pack = EventPack.find_by(id: params[:registration_pack])
      if !@event_pack
        render_404
      end
    end
  end

end
