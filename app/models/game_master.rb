class GameMaster < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true, numericality: true
  validates :description, length: { maximum: 300 }, allow_blank: true

  after_commit :add_game_master_role_to_user

  private

  def add_game_master_role_to_user
    return if user.user_roles.game_master.first

    user.user_roles.create!(role: :game_master)
  end
end
