class Queen < Piece
  def to_unicode
    black? ? "\u265B" : "\u2655"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x.to_i - x_position.to_i).abs
    distance_y = (destination_y.to_i - y_position.to_i).abs
    return false if horizontal_obstruction?(destination_x, destination_y)
    return false if vertical_obstruction?(destination_x, destination_y)
    return false if diagonal_obstruction?(destination_x, destination_y)
    return true if distance_x.to_i == distance_y.to_i
    return true if distance_x.zero? && distance_y.to_i > 0
    return true if distance_y.zero? && distance_x.to_i > 0
    false
  end
end
