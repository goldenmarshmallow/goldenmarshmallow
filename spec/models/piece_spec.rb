require 'rails_helper'
RSpec.describe Piece, type: :model do
  it 'will check if a piece is obstructed' do
    game = FactoryBot.create(:game)
    king = FactoryBot.create(:piece, x_position: 4, y_position: 0, color: :white, type: :king, game: game)
    expect(king.obstructed?(4, 1)).to eq false
    rook = FactoryBot.create(:piece, x_position: 0, y_position: 0, color: :white, type: :rook, game: game)
    expect(rook.obstructed?(5, 0)).to eq true
    knight = FactoryBot.create(:piece, x_position: 1, y_position: 0, color: :white, type: :knight, game: game)
    expect(knight.obstructed?(2, 2)).to eq 'Invalid Input'
    pawn = FactoryBot.create(:piece, x_position: 2, y_position: 1, color: :white, type: :pawn, game: game)
    expect(pawn.obstructed?(2, 3)).to eq false
    bishop = FactoryBot.create(:piece, x_position: 2, y_position: 0, color: :white, type: :bishop, game: game)
    expect(bishop.obstructed?(3, 1)).to eq false
    queen = FactoryBot.create(:piece, x_position: 3, y_position: 0, color: :white, type: :queen, game: game)
    expect(queen.obstructed?(3, 3)).to eq false
  end

  it 'will check if a king\'s move is valid' do
    game = FactoryBot.create(:game)
    king = FactoryBot.create(:king, x_position: 4, y_position: 0, color: :white, type: :king, game: game)
    expect(king.valid_move?(4, 1)).to eq true
    king = FactoryBot.create(:king, x_position: 4, y_position: 0, color: :white, type: :king, game: game)
    expect(king.valid_move?(4, 3)).to eq false
    king = FactoryBot.create(:king, x_position: 4, y_position: 0, color: :white, type: :king, game: game)
    expect(king.valid_move?(4, 0)).to eq true
    king = FactoryBot.create(:king, x_position: 4, y_position: 3, color: :white, type: :king, game: game)
    expect(king.valid_move?(5, 0)).to eq false
  end
end
