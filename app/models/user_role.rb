class UserRole < ApplicationRecord
  belongs_to :user

  enum role: { superadmin: 0, admin: 10, game_master: 20, player: 30 }

  validates_uniqueness_of :role, scope: :user_id
end
