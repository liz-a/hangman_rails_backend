class GameController < ApplicationController
  # before_action :set_list, only: [:show, :edit, :update, :destroy]
  def index
    @games = Game.all
    render :index
  end
end