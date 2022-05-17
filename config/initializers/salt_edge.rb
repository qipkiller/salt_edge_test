require 'salt_edge'

if Rails.env.production?
  SaltEdge::Client.instance.configure(logger: Rails.logger)
else
  api_key = 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA'
  secret = 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks'
  SaltEdge::Client.instance.configure(api_key, secret, 'XF', 'fakebank_simple_xf', Rails.logger)
end
