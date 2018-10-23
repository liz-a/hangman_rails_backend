require "faker"

module GamesHelper
  class GenerateGame
    def initialize(game_name)
      @game_name = game_name
      @word = Faker::Verb.base
    end
    def new_game_data
      {"game_name"=>@game_name, "word"=>@word, "lives"=>"13", "status"=>"1"}
    end
    def generate_initial_word_display
      @game = Game.find_by(game_name: "#{@game_name}")
      display = @word.chars.map { |char| char = "?" }.join(" ") 
      @game.update(word_display: "#{display}")
      display + " WORD: #{@word}"
    end
    def display_word_state
      generate_initial_word_display
      # if join, just retrieve game display from game and display
    end
  end
  def generate_game(game_name)
    GenerateGame.new(game_name)
  end
end
