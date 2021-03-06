class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
  end

  # GET /guesses/1
  # GET /guesses/1.json
  def show
  end

  # GET /guesses/new
  def new
    @guess = Guess.new
  end

  # GET /guesses/1/edit
  def edit
  end

  # GET /guesses/exists/slack_id/guess
  def exists

    player_records = Player.find_by(slack_id: "#{params["slack_id"]}")
    
    active_game_id = player_records["active_game"]

    guess_exists = Guess.exists?(game_id: "#{active_game_id}", guess: "#{params["guess"]}")

    game_records = Game.find(active_game_id)
    game_name = game_records["game_name"]

    render :json => {guess_exists: "#{guess_exists}", game_name: "#{game_name}"}

  end

  # POST /guesses
  # POST /guesses.json
  def create

    game_id = params["game_id"]

    guess = params["guess"]

    guess_handler = helpers.generate_guess_handler(game_id,guess)

    @guess = Guess.new({ guess: "#{guess}", game_id: "#{game_id}", correct_or_incorrect: "#{guess_handler.guess_correct?}" })
    
    if @guess.save
      if guess_handler.guess_correct? == 1
        guess_handler.update_word_display
        guess_handler.check_for_win
      else
        guess_handler.update_guessed_letters
        guess_handler.update_lives
        guess_handler.check_for_lose
      end
      render :json => guess_handler.display
    else
      render json: @guess.errors, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /guesses/1
  # PATCH/PUT /guesses/1.json
  def update
    respond_to do |format|
      if @guess.update(guess_params)
        format.html { redirect_to @guess, notice: 'Guess was successfully updated.' }
        format.json { render :show, status: :ok, location: @guess }
      else
        format.html { render :edit }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guesses/1
  # DELETE /guesses/1.json
  def destroy
    @guess.destroy
    respond_to do |format|
      format.html { redirect_to guesses_url, notice: 'Guess was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:guess, :game_id, :correct_or_incorrect)
    end
end
