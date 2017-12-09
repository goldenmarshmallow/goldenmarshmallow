class Knight < Piece
  def to_unicode
    black? ? "\u265E" : "\u2658"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x.to_i - x_position.to_i).abs
    distance_y = (destination_y.to_i - y_position.to_i).abs

    return true if distance_x + distance_y == 3 && (distance_x > 0) && (distance_y > 0)
    false
  end
end
