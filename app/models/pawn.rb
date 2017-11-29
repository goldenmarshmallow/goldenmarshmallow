class Pawn < Piece
  def to_unicode
    black? ? "\u265F" : "\u2659"
  end
end
