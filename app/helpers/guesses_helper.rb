module GuessesHelper
  class GuessHandler
    def initialize(game_id, guess)
      @game_id = game_id
      @guess = guess
    end

    def guess_correct?
      game_records = Game.find(@game_id)
      @word = game_records["word"]
      @word.include?(@guess) ? 1 : 0
    end

    def update_word_display
      # Rails.logger.info 'UPDATE STARTED'
      correct_guesses = Guess.where(game_id: @game_id, correct_or_incorrect: "1")
      array_of_correct_guesses = correct_guesses.to_a.map! { |entry| entry["guess"] }

      word_display = @word.chars.map do |char| 
        array_of_correct_guesses.include?(char) ? char : '?'
      end.join(" ")

      @game = Game.find(@game_id)
      @game.update(word_display: "#{word_display}")

    end
    
    def update_guessed_letters
      incorrect_guesses = Guess.where(game_id: @game_id, correct_or_incorrect: "0")
      array_of_incorrect_guesses = incorrect_guesses.to_a.map! { |entry| entry["guess"] }
    end

    def update_lives
    end

    def display
    end

  end

  def generate_guess_handler(game_id, guess)
    GuessHandler.new(game_id, guess)
  end

end
