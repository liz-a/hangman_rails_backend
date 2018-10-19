json.extract! player, :id, :slack_name, :slack_id, :active_game, :created_at, :updated_at
json.url player_url(player, format: :json)
