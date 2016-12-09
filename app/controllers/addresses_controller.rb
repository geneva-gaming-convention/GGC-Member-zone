class AddressesController < ApplicationController
  before_action :must_be_logged
  before_action :must_be_proprietary, only: [:create]

  def new

  end

  def create
    new_addr = Address.find_or_create_by(address_params)
    user = current_logged_user
    user.address = new_addr
    user.password_confirmation = user.password
    if new_addr.save && user.save
      head 200, content_type: "text/html"
    else
      head 500, content_type: "text/html"
    end
  end

  def address_params
    params.require(:address).permit(:street, :number)
  end
end
