class User < ApplicationRecord
  has_many :games

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  enum role: %i[PLAYER DM ADMIN SUPERADMIN]

  validates :first_name, length: { in: 2..50 }, presence: true
  validates :last_name, length: { in: 3..50 }, presence: true
  validates :password, length: { in: 6..30 }, presence: true
  validates :username, length: { in: 3..30 }, presence: true
  validates :date_of_birth, presence: true

  def age
    Date.current.year - self.date_of_birth.year
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
