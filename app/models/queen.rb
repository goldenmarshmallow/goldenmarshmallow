class Queen < Piece
  def to_unicode
    black? ? "\u265B" : "\u2655"
  end
  
  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x - x_position).abs
    distance_y = (destination_y - y_position).abs

    distance_x == distance_y || distance_x == 0 || distance_y == 0
  end
end
