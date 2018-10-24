Rails.application.routes.draw do
  resources :guesses
  resources :players
  resources :games

  get "/games/exists/:game_name", to: "games#exists"

  get "/guesses/exists/:slack_id/:guess", to: "guesses#exists"

  get "/players/exists/:slack_id", to: "players#exists"

  # post "/slack", to: "slack#get_input"

  # post "/slack", to: "games#create", constraint: SlackCreateGameConstraint.new
  # post "/slack", to: "guesses#update", constraint: SlackGuessConstraint.new
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#show"

end
