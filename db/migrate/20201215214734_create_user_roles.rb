class CreateUserRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.integer :role, default: 30, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
