require 'rails_helper'

RSpec.describe 'Panel::Games', type: :request do
  let(:user) { create(:user) }
  let(:game) { create(:game, user: user) }
  let(:sign_in_method) { sign_in user }
  let(:game_attributes) { attributes_for(:game) }
  let(:params) { { game: game_attributes } }

  before { sign_in_method }

  describe 'GET /index' do
    before { get '/panel/games' }

    context 'when user is sign in' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not sign in' do
      let(:sign_in_method) { nil }

      it 'returns http status code 302' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /show' do
    before { get "/panel/games/#{game.id}" }

    context 'when user is sign in' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not sign in' do
      let(:sign_in_method) { nil }

      it 'returns http status core 302' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /new' do
    before { get '/panel/games/new' }

    context 'when user is sign in' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not sign in' do
      let(:sign_in_method) { nil }

      it 'returns http status core 302' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST /create' do
    let(:post_request) { post '/panel/games', params: params }

    context 'when user is sign in' do
      context 'when params is valid' do
        it 'returns redirect to game page' do
          expect(post_request).to redirect_to panel_game_path(Game.last)
        end

        it 'create new game' do
          expect { post_request }.to change(Game, :count).by 1
        end

        it 'assign new game to current_user' do
          post_request
          expect(Game.last.user.id).to eq user.id
        end

        context 'when params has not permiter params' do
          before { game_attributes[:id] = 23 }

          it "doesn't create game with these params" do
            expect { post_request }.to change(Game, :count).by 1
            expect(Game.last.id).to_not eq 23
          end
        end
      end

      context 'when params is not valid' do
        context 'when title is to short' do
          before { game_attributes[:title] = 'fo' }

          it 'renders new page' do
            post_request
            expect(response).to render_template('panel/games/new')
          end

          it "doesn't create new game" do
            expect { post_request }.to change(Game, :count).by 0
          end
        end

        context 'when start_date has wrong format' do
          before { game_attributes[:start_date] = 'foo' }

          it 'renders new page' do
            post_request
            expect(response).to render_template('panel/games/new')
          end

          it "doesn't create new game" do
            expect { post_request }.to change(Game, :count).by 0
          end
        end
      end
    end

    context 'when user is not sign in' do
      let(:sign_in_method) { nil }

      it 'returns http status core 302' do
        post_request
        expect(response).to have_http_status(302)
      end

      it "doesn't create new game" do
        expect { post_request }.to change(Game, :count).by 0
      end
    end
  end

  describe 'GET /edit' do
    before { get "/panel/games/#{game.id}/edit" }

    context 'when user is sign in' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not sign in' do
      let(:sign_in_method) { nil }

      it 'returns http status core 302' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'PUT /update' do
    let(:put_request) { put "/panel/games/#{game.id}", params: params }
    let(:params) { { game: { title: 'titme', max_level: 9 } } }

    context 'when user is sign in' do
      context 'when params is valid' do
        it 'returns http success' do
          expect(put_request).to redirect_to panel_game_path(game)
        end

        it 'updates game params' do
          put_request
          expect(game.reload.title).to eq params[:game][:title]
          expect(game.reload.max_level).to eq params[:game][:max_level]
        end
      end

      context 'when params is not valid' do
        let(:params) { { game: { title: '12', max_level: 2, id: 1, user_id: 2 } } }

        it 'render edit template' do
          put_request
          expect(response).to render_template('panel/games/edit')
        end

        it "doesn't update game's params" do
          put_request
          expect(game.reload.title).to_not eq params[:game][:title]
          expect(game.reload.title).to eq game.title
          expect(game.reload.max_level).to_not eq params[:game][:max_level]
          expect(game.reload.max_level).to eq game.max_level
          expect(game.reload.id).to_not eq params[:game][:id]
          expect(game.reload.id).to eq game.id
          expect(game.reload.user_id).to_not eq params[:game][:user_id]
          expect(game.reload.user_id).to eq game.user_id
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:game_id) { game.id }
    let(:delete_request) { delete "/panel/games/#{game_id}" }

    context 'when user is sign in' do
      context 'when game is exist' do
        it 'redirects to index' do
          delete_request
          expect(response).to redirect_to panel_games_path
        end

        it 'deletes game' do
          game
          expect { delete_request }.to change(Game, :count).by -1
        end
      end

      context 'when game is not exist' do
        let(:game_id) { 2 }

        it 'redirects to index' do
          delete_request
          expect(response).to redirect_to panel_games_path
        end

        it "doesn't destroy game" do
          game
          expect { delete_request }.to change(Game, :count).by 0
        end
      end
    end

    context 'when user is not sign in' do
      let(:sign_in_method) { nil }

      it 'redirects to index' do
        delete_request
        expect(response).to have_http_status(302)
      end

      it "doesn't destroy game" do
        game
        expect { delete_request }.to change(Game, :count).by 0
      end
    end
  end
end
