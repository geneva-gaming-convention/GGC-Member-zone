require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "put_customer" do
    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]

    ret = InfomaniakHelper.get_customer("john.doe@infomaniak.com", credential)
    customer_key = ret[0]["key"]
    customer_email = ret[0]["email"]

    payload = {
      "civility"=> "Mr",
      "firstname"=> "Doe",
      "lastname"=> "John",
      "password"=> "password",
      "email"=> "john.doe@infomaniak.com",
      "language"=> "fr",
      "firm"=> "Infomaniak",
      "address"=> "Route De Frontenex 55",
      "city"=> "Genève",
      "zipcode"=> "1207",
      "country"=> "SWITZERLAND"
    }

    ret = InfomaniakHelper.put_customer(payload, credential, customer_key, customer_email)
    puts "put_customer\n\n"
    puts ret

  end


end
