class Knight < Piece
  def to_unicode
    black? ? "\u265E" : "\u2658"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x - x_position).abs
    distance_y = (destination_y - y_position).abs

    return true if (distance_x == 1 && distance_y == 2) || (distance_x == 2 && distance_y == 1)
    false
  end
end
