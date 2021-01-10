require 'rails_helper'

RSpec.describe GameMaster, type: :model do
  let(:user) { user_player }
  let(:user_player) { create(:user) }
  let(:user_game_master) { create(:user, :role_game_master) }

  describe '.add_game_master_role_to_user' do
    context 'when user role is player' do
      it 'adds new role to user' do
        create(:game_master, user: user)
        expect(user.user_roles_game_master).to_not be_empty
      end
    end

    context 'when user role is game_master' do
      let(:user) { user_game_master }

      it "doesn't create new UserRole" do
        user
        expect { create(:game_master, user: user) }.to_not change(UserRole, :count)
      end
    end
  end
end
