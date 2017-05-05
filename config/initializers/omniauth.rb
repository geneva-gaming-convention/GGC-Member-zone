Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, Rails.application.secrets.steam_web_api_key
  provider :bnet, Rails.application.secrets.bnet_api_key, Rails.application.secrets.bnet_api_secret
end
