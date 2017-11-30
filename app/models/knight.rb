class Knight < Piece
  def to_unicode
    black? ? "\u265E" : "\u2658"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x - x_position).abs
    distance_y = (destination_y - y_position).abs

    (0 < distance_x) && (distance_x < 3) && (0 < distance_y) && (distance_y < 3)
    (distance_x - distance_y).abs == 1
  end
end
