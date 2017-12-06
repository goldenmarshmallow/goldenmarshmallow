class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    if @game.valid?
      redirect_to game_path(@game)
      @game.update_attributes(white_player_id: @game.user_id)
      @game.populate_board
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @game = Game.find_by(id: params[:id])
    return render_not_found if @game.blank?
  end

  def update
    @game = Game.find_by(id: params[:id])
    return render_not_found if @game.blank?
    if @game.valid?
      redirect_to game_path(@game)
      @game.update_attributes(black_player_id: @game.user_id)
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
