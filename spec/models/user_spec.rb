require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:customer_id) { Faker::Number.number(digits: 10).to_s }

  let(:user) { create(:user, customer_id: Faker::Number.number(digits: 10)) }

  
  subject do
    described_class.new(
      email: email,
      password: password
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it 'is valid after create' do
    expect(subject).to be_valid
    expect(subject.customer_id).to be_nil
    expect(subject.secret).to be_nil

    stub_request(:post, 'https://www.saltedge.com/api/v5/customers')
      .with(
        body: "{\"data\":{\"identifier\":\"#{subject.email}\"}}",
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'App-Id' => 'pS0REB_L0xKOiYLd0Kqgs8xa2rCUnoukT8vgBHIq5WA',
          'Content-Type' => 'application/json',
          'Secret' => 'zaHy8FEGwAsuPGFZI4tE9C_HdPafz4rhRxUKwz9Ogks',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{ "data": { "id": "' + customer_id + '", "identifier": "' + subject.email + '", "secret": "OgtyRzzO7VHwUElwqBnVUOgC7RdQ7OaPFoiG2hYXzpE" } }', headers: {})

    subject.save
    expect(subject.customer_id).not_to be_nil
    expect(subject.customer_id).to eql(customer_id.to_i)
    expect(subject.secret).not_to be_nil

    stub_request(:delete, "https://www.saltedge.com/api/v5/customers/#{customer_id}")
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
      .to_return(status: 200, body: '{ "data": { "id": "' + customer_id + '", "deleted": true } }', headers: {})
    subject.destroy
  end

  it 'have connections' do
    connection = create(:connection, user: user) 
    expect(user.connections.first).to eql(connection)
  end
end
