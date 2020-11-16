class AddAvatarUsernameAgeDateOfBirthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar, :string
    add_column :users, :username, :string, null: false, limit: 30
    add_column :users, :date_of_birth, :date, null: false
  end
end