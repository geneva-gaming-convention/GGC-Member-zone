module InfomaniakHelper

  def self.init_vars
    @end_point = "https://etickets.infomaniak.com/api/shop/"
    @header = {
      "Accept-Language" => "fr_FR",
      "key" => Rails.application.secrets.infomaniak_api_key,
      "currency" => "1"
    }
  end

  def self.get_login
    begin
      init_vars
      @header = {
        "user" => Rails.application.secrets.infomaniak_login_user,
        "password" => Rails.application.secrets.infomaniak_login_password
      }
      url = @end_point+"login"
      response = RestClient.get(url, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error":"failed to connect"}')
    end
  end

  def self.post_create_customer(payload, credential)
    # begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"customer/create"
      response = RestClient.post(url, payload.to_json, header=@header)
      response = JSON.parse(response)
      return response
    # rescue
    #   return JSON.parse('{"error":"User already exist"}')
    # end
  end

  def self.post_create_customer_from_user(user, credential)
    payload = {
      "firstname"=> user.name.capitalize,
      "lastname"=> user.lastname.capitalize,
      "email"=> user.mail,
      "address"=> user.address.street+" "+user.address.number,
      "city"=> user.address.locality.name,
      "zipcode"=> user.address.locality.postal_code,
      "country"=> user.address.locality.state.country.name
    }
    return self.post_create_customer(payload, credential)
  end

  def self.get_customer(email, credential)
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"customers?search="+CGI::escapeHTML(email)
      response = RestClient.get(url, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "User doesn\'t exist"}')
    end
  end

  def self.get_events(credential)
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"events"
      response = RestClient.get(url, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "No events found!"}')
    end
  end

  def self.get_zones(event_id, credential)
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"event/"+event_id.to_s+"/zones"
      response = RestClient.get(url, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "No Zones found!"}')
    end
  end

  def self.post_order(credential)
     begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"order/create"
      response = RestClient.post(url, {}, header=@header)
      response = response.body.to_s.gsub('"', '')
      response = { "order_id" => response}
      return response
    rescue
      return JSON.parse('{"error": "Something wrong"}')
    end
  end

  def self.post_ticket(category_id, order_id, credential)
    begin
      init_vars
      payload = {
        category_id => 1
      }
      @header["credential"] = credential
      url = @end_point+"order/"+order_id.to_s+"/tickets"
      response = RestClient.post(url, payload.to_json, header=@header)
      repsonse = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "No order has created"}')
    end
  end

  def self.get_bank_payment_form(mode, url_cancel, url_success, url_error, order_id, credential)
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"order/"+order_id.to_s+"/payment?mode="+mode+"&url_default="+CGI::escapeHTML(url_cancel)+"&url_ok="+CGI::escapeHTML(url_success)+"&url_error="+CGI::escapeHTML(url_error)
      response = RestClient.get(url, header=@header)
      response = { "form" => response.body }
      return response
    rescue
      return JSON.parse('{"error": "Sorry we can\'t get any payment method"}')
    end
  end

  def self.post_add_payment_to_order(price, payment_id, order_id, crendetial)
    begin
      init_vars
      payload = {
        payment_id => price
      }
      @header["crendetial"] = credential
      url = @end_point+"order/"+order_id+"/operations"
      response = RestClient.post(url, payload.to_json, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "No order found or wrong price/payment"}')
    end
  end

  def self.get_payment_list(order_id, credential)
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"order/"+order_id.to_s+"/payments"
      response = RestClient.get(url, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "No payment method found"}')
    end
  end

  def self.post_link_customer_to_order(customer_id, order_id, credential)
    begin
      init_vars
      payload = {
        "customer_id" => customer_id
      }
      @header["credential"] = credential
      url = @end_point+"order/"+order_id.to_s+"/customer"
      response = RestClient.post(url, payload.to_json, header=@header)
      response = {"status" => response.body}
      return response
    rescue
      return JSON.parse('{"error": "Invalid customer or order"}')
    end
  end

  def self.get_order(order_id, credential)
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"order/"+order_id.to_s
      response = RestClient.get(url, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "No order found"}')
    end
  end

  def self.put_customer(payload, credential, customer_key, customer_email)
    begin
      init_vars
      @header["credential"] = credential
      @header["customer_key"] = customer_key
      @header["customer_email"] = customer_email
      url = @end_point+"customer"
      response = RestClient.put(url, payload.to_json, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error": "Customer not found"}')
    end
  end
end
