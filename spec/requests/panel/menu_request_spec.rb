require 'rails_helper'

RSpec.describe "Panel::Menus", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/panel/menu/index"
      expect(response).to have_http_status(:success)
    end
  end

end
