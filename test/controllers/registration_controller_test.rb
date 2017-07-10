require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  credential = ""

  # get_login
  test "get_login" do
    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]
    puts "get login\n\n"
    puts ret
  end

  # post_create_customer
  test "post_create_customer" do
    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]

    payload = {
      "civility"=> "Mrs",
      "firstname"=> "Doesqzdqzd",
      "lastname"=> "Johnaqzdqzd",
      "email"=> "john.doe@infomaniakmdqdzqdqzdqzdzdrsqzdqzdbbbbb.com",
      "password"=> "jojoDoDo42",
      "firm"=> "Infomaniakqzdqzd",
      "address"=> "Route De Frontenex 55",
      "city"=> "Genève",
      "zipcode"=> "1207",
      "country"=> "SWITZERLAND"
    }
    ret = InfomaniakHelper.post_create_customer(payload, credential)
    puts "post create customer\n\n"
    puts ret
  end

  # get_customer
  test "get_customer" do
    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]

    ret = InfomaniakHelper.get_customer("john.doe@infomaniak.com", credential)
    puts "get customer\n\n"
    puts ret
  end

  # get_events
  test "get_events" do
    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]

    ret = InfomaniakHelper.get_events(credential)
    puts "get events\n\n"
    puts ret
  end

  test "get_zones" do
    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]

    ret = InfomaniakHelper.get_zones(79633, credential)
    puts "get zones\n\n"
    puts ret

  end

  test "post_order" do

    ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
    credential = ret["credential"]

    ret = InfomaniakHelper.post_order(credential)
    puts "post order\n\n"
    puts ret

  end

end
