require 'rails_helper'
require 'webmock/rspec'

describe SaltEdge::Client do
  let(:email) { Faker::Internet.email }
  let(:customer_id) { Faker::Number.number(digits: 10).to_s }
  describe '#create_customer' do
    it 'send a post request to create customer' do
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
      data = {
        data: {
          identifier: email
        }
      }
      customer = SaltEdge::Client.instance.create_customer({ body: data })
      expect(customer.response.code).to eq(200)
      expect(customer.data.id).to eq(customer_id)
      expect(customer.data.identifier).to eq(email)
      expect(customer.data.secret).to eq('OgtyRzzO7VHwUElwqBnVUOgC7RdQ7OaPFoiG2hYXzpE')
    end
  end

  describe '#remove_customer' do
    it 'send a delete request to remove customer' do
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

      customer = SaltEdge::Client.instance.remove_customer(customer_id)
      expect(customer.response.code).to eq(200)
      expect(customer.data.id).to eq(customer_id)
      expect(customer.data.deleted).to eq(true)
    end
  end
end
