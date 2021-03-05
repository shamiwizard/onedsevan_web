class User < ApplicationRecord
  has_one :game_master, dependent: :destroy
  has_many :games
  has_many :user_roles, dependent: :destroy
  has_many :characters, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:username]

  delegate :superadmin, :admin, :game_master, :player, to: :user_roles, prefix: true

  validates :first_name, length: { in: 2..50 }, presence: true
  validates :last_name, length: { in: 3..50 }, presence: true
  validates :password, length: { in: 6..30 }, presence: true
  validates :username, length: { in: 3..30 }, presence: true
  validates :date_of_birth, presence: true

  after_save :create_default_role

  def age
    Date.current.year - self.date_of_birth.year
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def create_default_role
    user_roles.new(role: 30).save
  end
end