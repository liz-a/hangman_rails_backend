class AddPlayerResponseUrl < ActiveRecord::Migration[5.2]
  def change
    change_table :players do |t|
      t.string :slack_response_url
    end
  end
end
