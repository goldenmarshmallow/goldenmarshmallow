require 'rails_helper'
RSpec.describe Piece, type: :model do
  it 'will check if a piece is obstructed' do
    game = FactoryBot.create(:game)
    king = FactoryBot.create(:piece, x_position: 4, y_position: 0, color: :white, type: :King, game: game)
    expect(king.obstructed?(4, 1)).to eq false
    rook = FactoryBot.create(:piece, x_position: 0, y_position: 0, color: :white, type: :Rook, game: game)
    expect(rook.obstructed?(5, 0)).to eq true
    knight = FactoryBot.create(:piece, x_position: 1, y_position: 0, color: :white, type: :Knight, game: game)
    expect(knight.obstructed?(2, 2)).to eq 'Invalid Input'
    pawn = FactoryBot.create(:piece, x_position: 2, y_position: 1, color: :white, type: :Pawn, game: game)
    expect(pawn.obstructed?(2, 3)).to eq false
    bishop = FactoryBot.create(:piece, x_position: 2, y_position: 0, color: :white, type: :Bishop, game: game)
    expect(bishop.obstructed?(3, 1)).to eq false
    queen = FactoryBot.create(:piece, x_position: 3, y_position: 0, color: :white, type: :Queen, game: game)
    expect(queen.obstructed?(3, 3)).to eq false
  end

  it 'will move to a new position' do
    game = FactoryBot.create(:game)
    king = FactoryBot.create(:piece, x_position: 4, y_position: 0, color: :white, type: :King, game: game)
    expect(king.move_to!(3, 0)).to eq false
    rook = FactoryBot.create(:piece, x_position: 0, y_position: 0, color: :white, type: :Rook, game: game)
    expect(rook.move_to!(4, 0)).to eq 'destination occupied by piece of same color'

    queen = FactoryBot.create(:piece, x_position: 3, y_position: 0, color: :white, type: :Queen, game: game)
    FactoryBot.create(:piece, x_position: 3, y_position: 4, color: :black, type: :Bishop, game: game)
    expect(queen.move_to!(3, 4)).to eq true
  end
end
