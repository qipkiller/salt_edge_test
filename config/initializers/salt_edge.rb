require 'salt_edge'

if Rails.env.production?
  app_id = ENV['SALT_EDGE_APP_ID']
  secret = ENV['SALT_EDGE_SECRET']
  country_code = ENV['SALT_EDGE_COUNTRY_CODE']
  provider_code = ENV['SALT_EDGE_PROVIDER_CODE']

  SaltEdge::Client.instance.configure(app_id, secret, country_code, provider_code, Rails.logger)
else
  app_id = 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA'
  secret = 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks'
  SaltEdge::Client.instance.configure(app_id, secret, 'XF', 'fakebank_simple_xf', Rails.logger)
end
