class Game < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :pieces

  def populate_board
    (0..7).each do |i|
      Pawn.create(
        game_id: id,
        x_position: i,
        y_position: 1,
        color: :white
      )
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0, color: :white)
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: :white)

    Knight.create(game_id: id, x_position: 1, y_position: 0, color: :white)
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: :white)

    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: :white)
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: :white)

    Queen.create(game_id: id, x_position: 3, y_position: 0, color: :white)
    King.create(game_id: id, x_position: 4, y_position: 0, color: :white)

    # black pieces
    (0..7).each do |i|
      Pawn.create(
        game_id: id,
        x_position: i,
        y_position: 6,
        color: :black
      )
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7, color: :black)
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: :black)

    Knight.create(game_id: id, x_position: 1, y_position: 7, color: :black)
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: :black)

    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: :black)
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: :black)

    Queen.create(game_id: id, x_position: 3, y_position: 7, color: :black)
    King.create(game_id: id, x_position: 4, y_position: 7, color: :black)
  end

  def self.available
    where('white_player_id IS NULL OR black_player_id IS NULL')
  end

  def check?
    # call the last
    last_move = Piece.last
    # find king
    king = Piece.find_by(type: 'King', color: last_move.color)
    # original position
    x = king.x_position
    y = king.y_position
    # move to the piece to the king using the last move
    opponent_pieces = Piece.where.not(color: last_move.color)
    # go througth all pieces of the adversary
    opponent_pieces.each do |piece|
      return true if piece.valid_move?(x_position, y_position)
    end
    false
  end
end
