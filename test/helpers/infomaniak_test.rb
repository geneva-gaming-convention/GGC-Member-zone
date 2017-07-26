require 'test_helper'

class InfomaniakHelperTest < ActionDispatch::IntegrationTest
  credential = ""
  order_id = ""
  category_id = ""

  # # get_login
  # test "get_login" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #   puts "get login\n\n"
  #   puts ret
  # end
  #
  # post_create_customer
  test "post_create_customer" do
    ret = InfomaniakHelper.get_login
    credential = ret["credential"]
    puts "!!!!! "+credential.inspect
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
  #
  # # get_customer
  # test "get_customer" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.get_customer("john.doe@infomaniak.com", credential)
  #   puts "get customer\n\n"
  #   puts ret
  # end
  #
  # # get_events
  # test "get_events" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.get_events(credential)
  #   puts "get events\n\n"
  #   puts ret
  # end
  #
  # test "get_zones" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.get_zones(79633, credential)
  #   category_id = ret[0]["categories"][0]["category_id"]
  #   puts "get zones\n\n"
  #   puts ret
  #
  # end
  #
  # test "post_order" do
  #
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.post_order(credential)
  #   puts "post order\n\n"
  #   puts ret
  #
  # end
  #
  # test "post_ticket" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.post_order(credential)
  #   order_id = ret["order_id"]
  #
  #   ret = InfomaniakHelper.get_zones(79633, credential)
  #   category_id = ret[0]["categories"][0]["category_id"]
  #
  #   ret = InfomaniakHelper.post_ticket(category_id, order_id, credential)
  #   puts "post_ticket\n\n"
  #   puts ret
  # end

  # test "get_order" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.post_order(credential)
  #   order_id = ret["order_id"]
  #
  #   ret = InfomaniakHelper.get_order(order_id, credential)
  #   puts "get_order\n\n"
  #   puts ret
  # end

  # test "post_link_customer_to_order" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.post_order(credential)
  #   order_id = ret["order_id"]
  #
  #   ret = InfomaniakHelper.get_customer("john.doe@infomaniak.com", credential)
  #   customer_id = ret[0]["id"]
  #
  #   ret = InfomaniakHelper.post_link_customer_to_order(customer_id, order_id, credential)
  #   puts "post_link_customer_to_order\n\n"
  #   puts %qret["status"]
  #   puts ret["status"].class
  #   puts ret
  # end

  # test "get_payment_list" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.post_order(credential)
  #   order_id = ret["order_id"]
  #
  #   ret = InfomaniakHelper.get_payment_list(order_id, credential)
  #   puts "get_payment_list\n\n"
  #   puts ret
  #
  # end

  # test "put_customer" do
  #   ret = InfomaniakHelper.get_login(Rails.application.secrets.infomaniak_email, Rails.application.secrets.infomaniak_password)
  #   credential = ret["credential"]
  #
  #   ret = InfomaniakHelper.get_customer("john.doe@infomaniak.com", credential)
  #   customer_key = ret[0]["key"]
  #   customer_email = ret[0]["email"]
  #
  #   payload = {
  #     "civility"=> "Mr",
  #     "firstname"=> "Doe",
  #     "lastname"=> "John",
  #     "password"=> "password",
  #     "email"=> "john.doe@infomaniak.com",
  #     "language"=> "fr",
  #     "firm"=> "Infomaniak",
  #     "address"=> "Route De Frontenex 55",
  #     "city"=> "Genève",
  #     "zipcode"=> "1207",
  #     "country"=> "SWITZERLAND"
  #   }
  #
  #   ret = InfomaniakHelper.put_customer(payload, credential, customer_key, customer_email)
  #   puts "put_customer\n\n"
  #   puts ret
  #
  # end


end
