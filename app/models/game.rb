class Game < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 3..50 }
  validates :description, presence: false, length: { maximum: 200 }
  validates :min_level, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }
  validates :max_level, presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }

  validates :max_players, presence: true, numericality: { only_integer: true }
  validates :player_count, numericality: { only_integer: true }
  validates :start_date, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }

  validate :level_is_in_valid_range, if: -> { min_level.present? }
  validate :date_is_not_in_pass, if: -> { start_date.present? }

  private

  def date_is_not_in_pass
    begin
      DateTime.parse start_date.to_s

      errors.add(:start_date, :date_is_in_pass) if DateTime.current >= start_date
    rescue Date::Error, TypeErrors
      errors.add(:start_date, :wrong_date_format)
    end
  end

  def level_is_in_valid_range
    return unless min_level.to_s.to_i == min_level || max_level.to_s.to_i == max_level

    errors.add(:min_level, :more_than_max_level) unless min_level < max_level
  end
end
