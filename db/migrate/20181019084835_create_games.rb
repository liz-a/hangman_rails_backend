class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :game_name
      t.string :word
      t.integer :lives
      t.integer :status
      t.integer :result

      t.timestamps
    end
  end
end
