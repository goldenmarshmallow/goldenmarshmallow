class PiecesController < ApplicationController
  def create
    @piece = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def update; end

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
