require 'httparty'

class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # include GamesHelper

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # GET /games/exists/game_name
  def exists
    game_exists = Game.exists?(game_name: "#{params["game_name"]}")
    render :json => {game_exists: "#{game_exists}"}
  end

  # POST /games
  # POST /games.json
  def create
    new_game = helpers.generate_game(params["game_name"])

    slack_id = params["slack_id"]

    response_url = params["response_url"]

    @game = Game.new(new_game.new_game_data)

    if @game.save
      player = Player.exists?(slack_id: "#{slack_id}")
      if player
        player_records = Player.find_by(slack_id: "#{slack_id}")
        Rails.logger.info player_records["id"].inspect
        render :json => {game_id: "#{@game.id}", player: "#{player}", player_id: "#{player_records["id"]}"}
      else
        render :json => {game_id: "#{@game.id}", player: "#{player}"}
      end
    else
      render json: @game.errors, status: :unprocessable_entity
    end

    word_blanks = new_game.display_word_state

    HTTParty.post(response_url, 
      {
        body: {"text" => "#{word_blanks}","response_type" => "in_channel"}.to_json,
        headers: {
          "Content-Type" => "application/json"
        }
      }
    )
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:game_name, :word, :lives, :status, :result )
    end
end
