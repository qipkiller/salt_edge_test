require 'rails_helper'

RSpec.describe "Connections", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/connections/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/connections/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/connections/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/connections/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
