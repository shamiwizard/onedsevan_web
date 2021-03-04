class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.integer :level, default: 0
      t.string :speciality
      t.string :race
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
