class RegistrationsController < ApplicationController
  before_action :must_be_logged
  before_action :event_must_exist,                      only: [:create, :is_still_free_slots]
  before_action :event_resource_must_exist,             only: [:create, :is_still_free_slots]
  before_action :event_pack_must_exist,                 only: [:create]

  def index

  end

  def create
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
        customer = nil
        user = User.find_by(id: current_logged_user.id)
        if !current_logged_user.remote_id
          customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken],
          :metadata => {
            "firstname"=>current_logged_user.name.capitalize,
            "lastname"=>current_logged_user.lastname.capitalize,
          }
          )
          user.password_confirmation = user.password
          user.remote_id = customer.id
          user.save
        else
          customer = Stripe::Customer.retrieve(user.remote_id)
          customer.email = user.mail
          customer.metadata = {
            "firstname"=>current_logged_user.name.capitalize,
            "lastname"=>current_logged_user.lastname.capitalize,
          }
          customer.source = params[:stripeToken]
          customer.save
        end
        charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => registration.event_pack.price.to_i*100,
        :description => registration.user.name.capitalize+" "+registration.user.lastname.capitalize+" | "+registration.event_pack.name,
        :currency    => 'chf',
        :metadata    => {
          "firstname" => registration.user.name.capitalize,
          "lastname" => registration.user.lastname.capitalize,
          "event" => registration.event.name,
          "event_resource" => registration.event_resource.title,
          "event_pack" => registration.event_pack.name,
        }
        )
        registration.paid = true
        registration.save
        flash[:success] = "You're registered"
      rescue Stripe::CardError => e
        registration.destroy
        flash[:danger] = e.message
      rescue => error
        registration.destroy
        flash[:danger] = "An error occurred while registering "+error.to_s
      end
      redirect_to event_event_resource_path(@event, @event_resource)
    else
      flash[:danger] = "An error occurred while registering, "+registration.errors.full_messages.to_sentence+". Don't worry, you didn't paid anything."
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
