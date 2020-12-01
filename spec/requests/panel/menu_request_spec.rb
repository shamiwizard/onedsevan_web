require 'rails_helper'

RSpec.describe 'Panel::Menus', type: :request do
  let(:user) { create(:user) }
  let(:sign_in_method) { sign_in user }

  describe 'GET /index' do
    before do
      sign_in_method
      get '/panel'
    end

    context 'when user is sign in' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not sign' do
      let(:sign_in_method) { nil }

      it 'returns http status code 302' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
