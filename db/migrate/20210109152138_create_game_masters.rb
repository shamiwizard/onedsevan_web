class CreateGameMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :game_masters do |t|
      t.references :user, null: false, index: { unique: true }, foreign_key: true
      t.text :description, null: true

      t.timestamps
    end
  end
end
