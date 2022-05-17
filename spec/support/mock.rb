require 'webmock/rspec'
RSpec.configure do |config|
  config.before(:each) do

    body_response = File.read(File.join('spec', 'fixtures', 'connections', 'new_connection_data.json'))
    stub_request(:post, 'https://www.saltedge.com/api/v5/connections')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'App-Id' => 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA',
          'Content-Type' => 'application/json',
          'Secret' => 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: body_response, headers: {})
  end
end