class King < Piece
  def to_unicode
    black? ? "\u265A" : "\u2654"
  end

  def valid_move?(destination_x, destination_y)
    origin_x = x_position
    origin_y = y_position
    distance_x = (destination_x - origin_x).abs
    distance_y = (destination_y - origin_y).abs

    (0..1).cover?(distance_x) && (0..1).cover?(distance_y)
  end
end
