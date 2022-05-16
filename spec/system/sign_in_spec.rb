require 'rails_helper'

describe 'User signs in', type: :system do
  before do
    @user = create :user, customer_id: Faker::Number.number(digits: 10).to_s
    visit new_user_session_path
  end

  scenario 'valid with correct credentials' do
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

    expect(@user.connections.active.count).to eql(0)
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button 'commit'

    expect(page).to have_text 'Signed in successfully'
    expect(page).to have_link 'Sign Out'
    expect(page).to have_current_path root_path
    expect(@user.connections.active.count).to eql(1)
    expect(@user.connections.first.remote_id).to eq(747_156_464_530_884_798)
  end

  scenario 'invalid with unregistered account' do
    fill_in 'user_email', with: Faker::Internet.email
    fill_in 'user_password', with: 'FakePassword123'
    click_button 'commit'

    expect(page).to have_no_text 'Welcome back'
    expect(page).to have_text 'Invalid Email or password.'
    expect(page).to have_no_link 'Sign Out'
    expect(@user.connections.active.count).to eql(0)
  end

  scenario 'invalid with invalid password' do
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'FakePassword123'
    click_button 'commit'

    expect(page).to have_no_text 'Welcome back'
    expect(page).to have_text 'Invalid Email or password.'
    expect(page).to have_no_link 'Sign Out'
    expect(@user.connections.active.count).to eql(0)
  end
end
