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

    Rails.logger.info '*' * 100
    Rails.logger.info params.inspect
    Rails.logger.info '*' * 100

    player_records = Player.find_by(slack_id: "#{params["slack_id"]}")

    Rails.logger.info '*' * 100
    Rails.logger.info player_records
    Rails.logger.info '*' * 100
    
    active_game_id = player_records["active_game"]

    Rails.logger.info '*' * 100
    Rails.logger.info active_game_id
    Rails.logger.info '*' * 100

    guess_exists = Guess.exists?(game_id: "#{active_game_id}", guess: "#{params["guess"]}")

    Rails.logger.info '*' * 100
    Rails.logger.info guess_exists
    Rails.logger.info '*' * 100

    render :json => {guess_exists: "#{guess_exists}", game_id: "#{active_game_id}"}

  end

  # POST /guesses
  # POST /guesses.json
  def create

    @guess = Guess.new({ guess: "#{params["guess"]}", game_id: "#{params["game_id"]}", correct_or_incorrect: "1" })

    respond_to do |format|
      if @guess.save
        format.html { redirect_to @guess, notice: 'Guess was successfully created.' }
        format.json { render :show, status: :created, location: @guess }
      else
        format.html { render :new }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
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
