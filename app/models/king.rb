class King < Piece
  def to_unicode
    black? ? "\u265A" : "\u2654"
  end
end
