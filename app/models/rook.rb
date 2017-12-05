class Rook < Piece
  def to_unicode
    black? ? "\u265C" : "\u2656"
  end

  def valid_move?(destination_x, destination_y)
    distance_x = (destination_x - x_position).abs
    distance_y = (destination_y - y_position).abs

    distance_x.zero? || distance_y.zero?
  end
end
