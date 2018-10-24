Rails.application.routes.draw do
  resources :guesses
  resources :players
  resources :games

  get "/games/exists/:game_name", to: "games#exists"

  get "/guesses/exists/:slack_id/:guess", to: "guesses#exists"

  get "/players/exists/:slack_id", to: "players#exists"

  get "images/13", to: "images#i13"
  get "images/12", to: "images#i12"
  get "images/11", to: "images#i11"
  get "images/10", to: "images#i10"
  get "images/9", to: "images#i9"
  get "images/8", to: "images#i8"
  get "images/7", to: "images#i7"
  get "images/6", to: "images#i6"
  get "images/5", to: "images#i5"
  get "images/4", to: "images#i4"
  get "images/3", to: "images#i3"
  get "images/2", to: "images#i2"
  get "images/1", to: "images#i1"
  get "images/0", to: "images#i0"

  # post "/slack", to: "slack#get_input"

  # post "/slack", to: "games#create", constraint: SlackCreateGameConstraint.new
  # post "/slack", to: "guesses#update", constraint: SlackGuessConstraint.new
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#show"

end
