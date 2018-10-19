json.extract! guess, :id, :guess, :game_id, :correct_or_incorrect, :created_at, :updated_at
json.url guess_url(guess, format: :json)
