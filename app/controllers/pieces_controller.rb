class PiecesController < ApplicationController
  before_action :authenticate_user!

  def create
    @piece = current_game.pieces.create(piece_params)
  end

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    if @piece.valid_move?(piece_params[:column], piece_params[:row])
      @piece.move_to!(piece_params[:column], piece_params[:row])
      redirect_to game_path(current_game)
    else
      redirect_to game_path(current_game), alert: 'Invalid move!'
    end
  end

  private

  def piece_params
    params.permit(:column, :row, :type)
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
