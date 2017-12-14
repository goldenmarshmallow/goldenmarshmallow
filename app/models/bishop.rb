class Bishop < Piece
  def to_unicode
    black? ? "\u265D" : "\u2657"
  end

  def valid_move?(destination_x, destination_y)
    origin_x = x_position
    origin_y = y_position
    distance_x = (destination_x - origin_x).abs
    distance_y = (destination_y - origin_y).abs

    distance_x == distance_y
  end
end
