require 'rails_helper'

describe 'User signs out', type: :system do
  before do
    @user = create :user, customer_id: Faker::Number.number(digits: 10).to_s
  end
  let(:connection_id) { 747_156_464_530_884_798 }

  scenario 'valid with correct credentials' do
    stub_request(:delete, "https://www.saltedge.com/api/v5/connections/#{connection_id}")
      .with(
        body: '{"data":{"fetch_scopes":["accounts","transactions"]}}',
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'App-Id' => 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA',
          'Content-Type' => 'application/json',
          'Secret' => 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{ "data": { "removed": true, "id": "' + connection_id.to_s + '" } }', headers: {})
    sign_in @user
    RemoteConnection::ConnectionCreator.call(@user)
    visit root_path
    expect(page).to have_current_path root_path
    expect(@user.connections.count).to eql(1)
    expect(@user.connections.active.count).to eql(1)
    expect(page).to have_link 'Sign Out'
    click_link 'Sign Out'
    RemoteConnection::ConnectionDestroyer.call(@user)
    expect(@user.connections.active.count).to eql(0)
    expect(@user.connections.count).to eql(1)
    expect(@user.connections.first.remote_id).to eq(connection_id)
  end
end
