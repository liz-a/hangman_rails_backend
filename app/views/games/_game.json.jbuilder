json.extract! game, :id, :game_name, :word, :lives, :status, :result, :created_at, :updated_at
json.url game_url(game, format: :json)
