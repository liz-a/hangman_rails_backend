require 'httparty'

class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token
  def get_input
    Rails.logger.info '*' * 100
    # Rails.logger.info params.inspect
    Rails.logger.info params["response_url"].inspect
    Rails.logger.info '*' * 100

    post_url = params["response_url"]

    response = HTTParty.post(post_url, 
      body: {"text" => "Hello, World!","response_type" => "in_channel"}.to_json,
      headers: {
        "Content-Type" => "application/json"
      }
    )

    # redirect_to @game, action: 'create', game_data: {"game_name"=>"HELLO WORLD", "word"=>"test", "lives"=>"13", "status"=>"1", "result"=>"1"}.to_json
    redirect_to new_game_path, game_data: {"game_name"=>"HELLO WORLD", "word"=>"test", "lives"=>"13", "status"=>"1", "result"=>"1"}.to_json
 

    head :ok
  end
end