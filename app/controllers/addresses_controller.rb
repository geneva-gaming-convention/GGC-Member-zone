class AddressesController < ApplicationController
  before_action :must_be_logged
  before_action :must_be_proprietary, only: [:create]

  def new

  end

  def create
    new_addr = Address.find_or_create_by(address_params)
    new_locality = Locality.find_or_create_by(postal_code: params["postal_code"], name: params["locality"])
    new_state = State.find_or_create_by(name: params["state"])
    new_country = Country.find_or_create_by(name: params["country"])
    new_addr.locality = new_locality
    new_locality.state = new_state
    new_state.country = new_country
    user = current_logged_user
    user.address = new_addr
    user.password_confirmation = user.password
    if new_addr.save && new_locality.save && new_state.save && user.save
      head 200, content_type: "text/html"
    else
      head 500, content_type: "text/html"
    end
  end

  def address_params
    params.require(:address).permit(:street, :number)
  end
end
