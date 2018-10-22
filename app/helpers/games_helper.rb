require "faker"

module GamesHelper
    def new_game_data(name)
      word = Faker::Verb.base
      {"game_name"=>name, "word"=>word, "lives"=>"13", "status"=>"1"}
    end
end
