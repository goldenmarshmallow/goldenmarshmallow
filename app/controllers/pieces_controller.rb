class PiecesController < ApplicationController
  before_action :authenticate_user!

  def create
    @piece = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    row = params[:row]
    column = params[:column]
    piece = Piece.find(params[:id])
    piece.move_to!(column, row)
    redirect_to game_path(current_game)
  end

  private

  def piece_params
    params.require(:piece).permit(:type)
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:game_id])
  end

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find(params[:id])
  end
end
