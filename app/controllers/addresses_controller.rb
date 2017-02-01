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
    if is_addr_valid(new_addr) && new_addr.save && new_locality.save && new_state.save && user.save
      #head 200, content_type: "text/html"
      @addr = new_addr
      render json: @addr
    else
      head 500, content_type: "text/html"
    end
  end

  def destroy
    address = Address.find_by(id: params["id"])
    user_addr = current_logged_user.address
    if ((address == user_addr) && address != nil)
      locality = user_addr.locality
      state = locality.state
      country = state.country
      if user_addr.delete
        if locality.addresses.count == 0
          locality.delete
          if state.localities.count == 0
            state.delete
            if country.states.count == 0
              country.delete
            end
          end
        end
        redirect_to edit_user_path(current_logged_user.id)
      else
        render_403
      end
    end
  end

  def get_valid_addr
    data = JT::Rails::Address.search(params["query"], Rails.application.secrets.google_maps_api_key)
    render json: data
  end

  def is_addr_valid(addr)
    full_addr = addr.to_string
    api_result = JT::Rails::Address.search(full_addr, Rails.application.secrets.google_maps_api_key)
    if api_result
      return true
    else
      return false
    end
  end

  def address_params
    params.require(:address).permit(:street, :number)
  end
end
