class Knight < Piece
  def to_unicode
    black? ? "\u265E" : "\u2658"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x - x_position).abs
    distance_y = (destination_y - y_position).abs

    return true if ((distance_x - distance_y).abs == 1) && (distance_x > 0) && (distance_x < 3) && (distance_y > 0) && (distance_y < 3)
    false
  end
end
