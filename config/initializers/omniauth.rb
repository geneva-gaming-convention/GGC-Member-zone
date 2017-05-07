Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, Rails.application.secrets.steam_web_api_key
end
