require 'rails_helper'
require 'spec_helper'
RSpec.describe 'Accounts', type: :request do
  before do
    @user = create :user, customer_id: Faker::Number.number(digits: 10).to_s
  end

  describe 'GET /index' do
    it 'returns http success' do
      sign_in @user
      get '/accounts/index'

      expect(response).to have_http_status(:success)
    end

    it 'return http redirect' do 
      get '/accounts/index'

      expect(response).to have_http_status(:redirect)
    end
  end
end
