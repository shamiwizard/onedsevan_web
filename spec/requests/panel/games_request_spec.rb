require 'rails_helper'

RSpec.describe 'Panel::Games', type: :request do
  let(:user) { create(:user) }
  let(:game) { create(:game, user: user) }

  before { sign_in user }

  describe "GET /index" do
    it "returns http success" do
      get "/panel/games"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/panel/game/#{game.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/panel/games/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/panel/games/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/panel/games/#{game.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      put "/panel/games/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      delete "/panel/games/#{game.id}/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
