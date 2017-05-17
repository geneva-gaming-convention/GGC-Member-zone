module ToornamentHelper

  def self.init_vars
    @end_point = "https://api.toornament.com/v1/"
    @header = { 'X-Api-Key' => Rails.application.secrets.toornament_api_key }
  end

  def self.get_tournament_by_id(tournament_id)
    begin
      init_vars
      url = @end_point+"tournaments/"+tournament_id.to_s
      response = RestClient.get(url, headers=@header)
      response = JSON.parse(response)
      return response
    rescue
      response = JSON.parse('{"error":"failed to get wished toornament event"}')
    end
  end

  def self.get_tournament_teams_participants(tournament_id)
    begin
      init_vars
      url = @end_point+"tournaments/"+tournament_id.to_s+"/participants"
      response = RestClient.get(url, headers=@header)
      response = JSON.parse(response)
      return response
    rescue Exception => e
      response = JSON.parse('{"error":"'+e.to_s+'"}')
    end
  end

  def self.get_tournament_teams_members(tournament_id, team_participant_id)
    begin
      init_vars
      url = @end_point+"tournaments/"+tournament_id.to_s+"/participants/"+team_participant_id.to_s
      response = RestClient.get(url, headers=@header)
      response = JSON.parse(response)
      team_members = response
      return team_members
    rescue Exception => e
      response = JSON.parse('{"error":"'+e.to_s+'"}')
    end
  end

end
