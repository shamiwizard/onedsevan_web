require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:build_game) { build(:game) }
  let(:user) { create(:user) }
  before { build_game.user_id = user.id }

  describe '.date_is_not_in_pass' do
    context 'when start_date is empty' do
      before { build_game.start_date = '' }

      it 'is not valid' do
        expect(build_game).to_not be_valid
        expect(build_game.errors[:start_date]).to_not be_empty
        expect(build_game.errors[:start_date]).to include I18n.t('errors.messages.blank')
        expect { build_game.save }.to change(Game, :count).by 0
      end
    end

    context 'when start_date is present' do
      context 'when start_date is wrong format' do
        before { build_game.start_date = 'asdasdas' }

        it 'is not valid' do
          expect(build_game).to_not be_valid
          expect(build_game.errors[:start_date]).to_not be_empty
          expect(build_game.errors[:start_date]).to include I18n.t('errors.messages.blank')
          expect { build_game.save }.to change(Game, :count).by 0
        end
      end

      context 'when start_date presemt' do
        context 'when start_date in a pass' do
          before { build_game.start_date = DateTime.current - 1.year }

          it 'is not valid' do
            expect(build_game).to_not be_valid
            expect(build_game.errors[:start_date]).to_not be_empty
            expect(build_game.errors[:start_date]).to include I18n.t('activerecord.errors.models.game.attributes.start_date.date_is_in_pass')
            expect { build_game.save }.to change(Game, :count).by 0
          end
        end

        context 'when start_date is good' do
          it 'create new game' do
            expect(build_game).to be_valid
            expect(build_game.errors[:start_date]).to be_empty
            expect { build_game.save }.to change(Game, :count).by 1
          end
        end
      end
    end
  end

  describe '.level_is_in_valid_range' do
    context 'when min_level is not present' do
      before { build_game.min_level = '' }

      it 'is not valid' do
        expect(build_game).to_not be_valid
        expect(build_game.errors[:min_level]).to_not be_empty
        expect(build_game.errors[:min_level]).to include I18n.t('errors.messages.blank')
        expect { build_game.save }.to change(Game, :count).by 0
      end
    end

    context 'when min_level is present' do
      context 'when min_level is not integer' do
        before { build_game.min_level = 'foo' }

        it 'is not valid' do
          expect(build_game).to_not be_valid
          expect(build_game.errors[:min_level]).to_not be_empty
          expect(build_game.errors[:min_level]).to include I18n.t('errors.messages.not_a_number')
          expect { build_game.save }.to change(Game, :count).by 0
        end
      end

      context 'when min_level is integer' do
        context 'when max_level is not integer' do
          before { build_game.max_level = 'foo' }

          it 'is not valid' do
            expect(build_game).to_not be_valid
            expect(build_game.errors[:max_level]).to_not be_empty
            expect(build_game.errors[:max_level]).to include I18n.t('errors.messages.not_a_number')
            expect { build_game.save }.to change(Game, :count).by 0
          end
        end

        context 'when max_level is integer' do
          it 'is not valid' do
            expect(build_game).to be_valid
            expect(build_game.errors[:max_level]).to be_empty
            expect { build_game.save }.to change(Game, :count).by 1
          end
        end
      end
    end
  end
end