class King < Piece
  def to_unicode
    black? ? "\u265A" : "\u2654"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x.to_i - x_position.to_i).abs
    distance_y = (destination_y.to_i - y_position.to_i).abs
    byebug
    return false if horizontal_obstruction?(destination_x, destination_y)
    byebug
    return false if vertical_obstruction?(destination_x, destination_y)
    byebug
    return false if diagonal_obstruction?(destination_x, destination_y)
    byebug
    return true if (distance_x <= 1) && (distance_y <= 1)
    byebug
    false
  end
end
