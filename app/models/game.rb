class Game < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :pieces
  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :black_player, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true

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

  def forfeit(current_user)
   
    update_attributes(winner_id: white_player_id, result: 'Forfeit') if current_user == black_player

    update_attributes(winner_id: black_player_id, result: 'Forfeit') if current_user == white_player
  end
end
