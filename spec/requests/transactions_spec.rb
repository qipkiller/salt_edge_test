require 'rails_helper'
RSpec.describe "Transactions", type: :request do
  before do
    @user = create :user, customer_id: Faker::Number.number(digits: 10).to_s
  end


  describe "GET /index" do
    it "returns http success" do
      sign_in @user
      RemoteConnection::ConnectionCreator.call(@user)
      get "/transactions/index?account_id=748907035034126662"
      expect(response).to have_http_status(:success)
    end
  end


  it 'return http redirect' do 
    get '/transactions/index'

    expect(response).to have_http_status(:redirect)
  end
end
