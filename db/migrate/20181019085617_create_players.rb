class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :slack_name
      t.string :slack_id
      t.integer :game_id
      t.integer :active_game
      t.integer :player_games

      t.timestamps
    end
  end
end
