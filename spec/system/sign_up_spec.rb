require 'rails_helper'
require 'webmock/rspec'
describe 'User signs up', type: :system do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:customer_id) { Faker::Number.number(digits: 10).to_s }

  before do
    visit new_user_registration_path
  end

  scenario 'with valid data' do
    stub_request(:post, 'https://www.saltedge.com/api/v5/customers')
      .with(
        body: '{"data":{"identifier":"' + email + '"}}',
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'App-Id' => 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA',
          'Content-Type' => 'application/json',
          'Secret' => 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{ "data": { "id": "' + customer_id + '", "identifier": "' + email + '", "secret": "OgtyRzzO7VHwUElwqBnVUOgC7RdQ7OaPFoiG2hYXzpE" } }', headers: {})
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

    

    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'commit'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'invalid when email already exists' do
    stub_request(:post, 'https://www.saltedge.com/api/v5/customers')
      .with(
        body: '{"data":{"identifier":"' + email + '"}}',
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'App-Id' => 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA',
          'Content-Type' => 'application/json',
          'Secret' => 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{ "data": { "id": "' + customer_id + '", "identifier": "' + email + '", "secret": "OgtyRzzO7VHwUElwqBnVUOgC7RdQ7OaPFoiG2hYXzpE" } }', headers: {})

    user = create :user, email: email

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'commit'

    expect(page).to have_no_text 'Welcome back'
    expect(page).to have_text 'Email has already been taken'
  end

  scenario 'invalid without different passwords' do
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: "#{password}1"
    click_button 'commit'

    expect(page).to have_no_text 'Welcome back'
    expect(page).to have_text "Password confirmation doesn't match Password"
  end
end
