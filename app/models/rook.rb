class Rook < Piece
  def to_unicode
    black? ? "\u265C" : "\u2656"
  end
end
