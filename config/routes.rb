Rails.application.routes.draw do
  resources :guesses
  resources :players
  resources :games
  post "/slack", to: "slack#get_input"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepage#show"

end
