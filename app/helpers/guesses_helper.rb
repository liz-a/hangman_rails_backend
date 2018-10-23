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

      @game = Game.find(@game_id)
      @game.update(guessed_letters_display: "GUESSED: #{array_of_incorrect_guesses.join(" ")}")
    end

    def update_lives
      @game = Game.find(@game_id)
      lives = @game["lives"] - 1
      @game.update(lives: lives)

    end

    def display
      @game = Game.find(@game_id)
      lives = @game["lives"]
      word_display = @game["word_display"]
      guessed_letters_display = @game["guessed_letters_display"]

      guess_message = @game["status"] == 1 ? "#{guess_correct? == 1 ? "CORRECT" : "INCORRECT" }" : "#{@game["result"] == 1 ? "YOU WIN" : "YOU LOSE"}"

      { lives: lives, guessed_letters_display: guessed_letters_display, word_display: word_display, guess_message: guess_message }
    end

    def check_for_win

      @game = Game.find(@game_id)
      @word_display = @game["word_display"]

      if @word.chars.join(" ") == @word_display
        @game.update( status: "0", result: "1" )
      end

    end

    def check_for_lose

      @game = Game.find(@game_id)
      @lives = @game["lives"]

      if @lives == 0
        @game.update( status: "0", result: "0" )
      end

    end

  end

  def generate_guess_handler(game_id, guess)
    GuessHandler.new(game_id, guess)
  end

end
