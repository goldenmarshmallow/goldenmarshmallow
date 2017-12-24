class Bishop < Piece
  def to_unicode
    black? ? "\u265D" : "\u2657"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x.to_i - x_position.to_i).abs
    distance_y = (destination_y.to_i - y_position.to_i).abs
    return false if obstructed?(destination_x, destination_y)
    return true if distance_x.to_i == distance_y.to_i
    false
  end
end
