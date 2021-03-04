class Character < ApplicationRecord
  belongs_to :user

  validates :first_name, length: { in: 2..50 }, presence: true
  validates :last_name, length: { maximum: 50 }
  validates :level, numericality: true, presence: true
  validates :speciality, length: { maximum: 30 }
  validates :race, length: { maximum: 30 }
end
