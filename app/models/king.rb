class King < Piece
  def to_unicode
    black? ? "\u265A" : "\u2654"
  end

  def valid_move?(destination_x, destination_y)
    origin_x = x_position
    origin_y = y_position
    distance_x = (destination_x.to_i - origin_x.to_i).abs
    distance_y = (destination_y.to_i - origin_y.to_i).abs

    return false if obstructed?(destination_x, destination_y)
    return true if (0..1).cover?(distance_x) && (0..1).cover?(distance_y)
    false
  end
end
