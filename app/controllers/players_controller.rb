class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # GET /player/exists/slack_id
  def exists
    player_exists = Player.exists?(slack_id: "#{params["slack_id"]}")

    player_id = nil
    if player_exists == true
      player_records = Player.find_by(slack_id: "#{params["slack_id"]}")
      player_id = player_records["id"]
    end

    render :json => {player_exists: "#{player_exists}", player_id: "#{player_id}"}
  end

  # POST /players
  # POST /players.json
  def create

    slack_id = params["slack_id"]
    slack_name = params["slack_name"]
    game_id = params["game_id"]

    @player = Player.new({"slack_name"=>"#{slack_name}","slack_id"=>"#{slack_id}","active_game"=>"#{game_id}"})

    if @player.save
      render :json => {player_id: "#{@player.id}"}
    else
      render json: @game.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      slack_id = params["slack_id"]
      slack_name = params["slack_name"]
      active_game = params["game_id"]
      if @player.update({slack_id: "#{slack_id}", slack_name: "#{slack_name}", active_game: "#{active_game}"})
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:slack_name, :slack_id, :active_game)
    end
end
