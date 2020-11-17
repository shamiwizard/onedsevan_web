class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title, null: false
      t.text :description
      t.string :image
      t.integer :min_level, null: false
      t.integer :max_level, null: false
      t.string :game_system
      t.integer :max_players, null: false
      t.integer :player_count, null: false, default: 0
      t.datetime :start_date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
