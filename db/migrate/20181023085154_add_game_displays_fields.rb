class AddGameDisplaysFields < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.string :word_display
      t.string :guessed_letters_display
    end
  end
end
