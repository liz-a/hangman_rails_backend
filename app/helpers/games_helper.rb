require "faker"

module GamesHelper
  class GenerateGame
    def initialize(game_name)
      @game_name = game_name
      @word = Faker::Verb.base
      @guesses = []
    end
    def new_game_data
      {"game_name"=>@game_name, "word"=>@word, "lives"=>"13", "status"=>"1"}
    end
    def display_word_state
      display = @word.chars.map { |char| char = "?" }.join(" ") 
      
      display + " WORD: #{@word}"
    end
  end
  def generate_game(game_name)
    GenerateGame.new(game_name)
  end
end
