class Bishop < Piece
  def to_unicode
    black? ? "\u265D" : "\u2657"
  end

  def valid_move?(destination_x, destination_y)
    origin_x = x_position
    origin_y = y_position
    distance_x = (destination_x.to_i - origin_x.to_i).abs
    distance_y = (destination_y.to_i - origin_y.to_i).abs

    return false if obstructed?(destination_x, destination_y)
    return true if distance_x == distance_y
    false
  end
end
