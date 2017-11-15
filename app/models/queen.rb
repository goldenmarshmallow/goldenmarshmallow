class Queen < Piece
  def to_unicode
    black? ? "\u265B" : "\u2655"
  end
end
