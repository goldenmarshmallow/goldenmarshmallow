class Pawn < Piece
  def to_unicode
    black? ? "\u265F" : "\u2659"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x.to_i - x_position.to_i)
    distance_y = (destination_y.to_i - y_position.to_i)

    return false if vertical_obstruction?(destination_x, destination_y)
    # white pawn obstructed
    return false if white? && distance_x.zero? && distance_y == 1 && game.pieces.find_by(x_position: destination_x, y_position: destination_y)

    # black pawn obstructed
    return false if black? && distance_x.zero? && distance_y == -1 && game.pieces.find_by(x_position: destination_x, y_position: destination_y)

    # white pawn first move
    return true if white? && y_position == 1 && (0..2).cover?(distance_y) && distance_x.zero?

    # black pawn first move
    return true if black? && y_position == 6 && (-2..0).cover?(distance_y) && distance_x.zero?

    # white pawn move
    return true if white? && y_position > 1 && (0..1).cover?(distance_y) && distance_x.zero?

    # black pawn move
    return true if black? && y_position < 6 && (-1..0).cover?(distance_y) && distance_x.zero?

    # white pawn capture
    return true if white? && distance_x.abs == 1 && distance_y == 1 && game.pieces.find_by(x_position: destination_x, y_position: destination_y, color: :black)

    # black pawn capture
    return true if black? && distance_x.abs == 1 && distance_y == -1 && game.pieces.find_by(x_position: destination_x, y_position: destination_y, color: :white)

    false
  end
end
