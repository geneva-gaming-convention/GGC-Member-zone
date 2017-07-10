module InfomaniakHelper

  def self.init_vars
    @end_point = "https://etickets.infomaniak.com/api/shop/"
    @header = {
      "Accept-Language" => "fr_FR",
      "key" => Rails.application.secrets.infomaniak_api_key,
      "currency" => "1"
    }
  end

  def self.get_login(email, password)
    begin
      init_vars
      @header = {
        "user" => email,
        "password" => password
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
    begin
      init_vars
      @header["credential"] = credential
      url = @end_point+"customer/create"
      response = RestClient.post(url, payload.to_json, header=@header)
      response = JSON.parse(response)
      return response
    rescue
      return JSON.parse('{"error":"User already exist"}')
    end
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
      response = { "order_id" => response}
      return response.to_json
    rescue
      return JSON.parse('{"error": "Something wrong"}')
    end
  end
end
