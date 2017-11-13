class Knight < Piece
  def to_unicode
    black? ? "\u265E" : "\u2658"
  end
end
