require 'rails_helper'
RSpec.describe Piece, type: :model do
  context 'pieces.obstructed? method' do
    it 'will check if a piece is horizontally obstructed' do
      game = FactoryBot.create(:game)
      rook = FactoryBot.create(:piece, x_position: 3, y_position: 3, color: :white, type: :Rook, game: game)
      queen = FactoryBot.create(:piece, x_position: 4, y_position: 3, color: :white, type: :Queen, game: game)
      expect(rook.obstructed?(6, 3)).to eq true
      expect(rook.obstructed?(1, 3)).to eq false
      expect(queen.obstructed?(2, 3)).to eq true

      rook = FactoryBot.create(:piece, x_position: 5, y_position: 5, color: :black, type: :Rook, game: game)
      queen = FactoryBot.create(:piece, x_position: 6, y_position: 5, color: :black, type: :Queen, game: game)
      expect(queen.obstructed?(4, 5)).to eq true
      expect(queen.obstructed?(7, 5)).to eq false
      expect(rook.obstructed?(2, 5)).to eq false
    end

    it 'will check if a piece is vertically obstructed' do
      game = FactoryBot.create(:game)
      rook = FactoryBot.create(:piece, x_position: 3, y_position: 3, color: :white, type: :Rook, game: game)
      queen = FactoryBot.create(:piece, x_position: 3, y_position: 4, color: :white, type: :Queen, game: game)
      expect(rook.obstructed?(3, 5)).to eq true
      expect(rook.obstructed?(3, 0)).to eq false
      expect(queen.obstructed?(3, 2)).to eq true

      rook = FactoryBot.create(:piece, x_position: 5, y_position: 5, color: :black, type: :Rook, game: game)
      queen = FactoryBot.create(:piece, x_position: 5, y_position: 6, color: :black, type: :Queen, game: game)
      expect(queen.obstructed?(5, 1)).to eq true
      expect(queen.obstructed?(5, 7)).to eq false
      expect(rook.obstructed?(5, 3)).to eq false
    end

    it 'will check if a piece is diagonally obstructed' do
      game = FactoryBot.create(:game)
      queen = FactoryBot.create(:piece, x_position: 3, y_position: 3, color: :white, type: :Queen, game: game)
      bishop = FactoryBot.create(:piece, x_position: 2, y_position: 2, color: :white, type: :Bishop, game: game)
      expect(bishop.obstructed?(5, 5)).to eq true
      expect(bishop.obstructed?(0, 0)).to eq false
      expect(queen.obstructed?(1, 1)).to eq true

      bishop = FactoryBot.create(:piece, x_position: 5, y_position: 4, color: :black, type: :Bishop, game: game)
      queen = FactoryBot.create(:piece, x_position: 6, y_position: 5, color: :black, type: :Queen, game: game)
      expect(queen.obstructed?(7, 6)).to eq false
      expect(queen.obstructed?(2, 1)).to eq true
      expect(bishop.obstructed?(3, 2)).to eq false
    end

    it 'will return invalid if a piece is not moving horizontally, vertically, or diagonally' do
      game = FactoryBot.create(:game)
      knight = FactoryBot.create(:piece, x_position: 3, y_position: 3, color: :white, type: :Knight, game: game)
      pawn = FactoryBot.create(:piece, x_position: 3, y_position: 4, color: :white, type: :Pawn, game: game)
      rook = FactoryBot.create(:piece, x_position: 3, y_position: 2, color: :white, type: :Rook, game: game)
      expect(knight.obstructed?(5, 4)).to eq 'Invalid Input'
      expect(knight.obstructed?(1, 4)).to eq 'Invalid Input'
      expect(knight.obstructed?(5, 2)).to eq 'Invalid Input'
      expect(knight.obstructed?(1, 2)).to eq 'Invalid Input'
      expect(rook.obstructed?(3, 5)).to eq true
      expect(pawn.obstructed?(3, 6)).to eq false
    end
  end

  it 'will move to a new position unless same color' do
    game = FactoryBot.create(:game)
    king = FactoryBot.create(:piece, x_position: 4, y_position: 0, color: :white, type: :King, game: game)
    expect(king.move_to!(3, 0)).to eq true
    rook = FactoryBot.create(:piece, x_position: 0, y_position: 0, color: :white, type: :Rook, game: game)
    expect(rook.move_to!(3, 0)).to eq 'destination occupied by piece of same color'
  end

  it 'will move to a new position and capture piece of opposite color' do
    game = FactoryBot.create(:game)
    queen = FactoryBot.create(:piece, x_position: 3, y_position: 0, color: :white, type: :Queen, game: game)
    bishop = FactoryBot.create(:piece, x_position: 3, y_position: 4, color: :black, type: :Bishop, game: game)
    expect(queen.move_to!(3, 4)).to eq true
    expect(queen.reload.x_position).to eq 3
    expect(queen.y_position).to eq 4
    expect(bishop.reload.x_position).to eq nil
    expect(bishop.y_position).to eq nil
  end
end
