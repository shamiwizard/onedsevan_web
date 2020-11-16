class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[PLAYER DM ADMIN SUPERADMIN]

  validates :first_name, length: { minimun: 3, maximum: 50 }, presence: true
  validates :last_name, length: { minimun: 3, maximum: 50 }, presence: true
  validates :password, length: { minimun: 6, maximum: 50 }, presence: true
  validates :password, length: { minimun: 6, maximum: 50 }, presence: true

  def age
    Date.current.year - self.date_of_birth.year
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
