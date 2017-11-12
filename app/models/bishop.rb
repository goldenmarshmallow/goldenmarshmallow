class Bishop < Piece
  def to_unicode
    black? ? "\u265D" : "\u2657"
  end
end
