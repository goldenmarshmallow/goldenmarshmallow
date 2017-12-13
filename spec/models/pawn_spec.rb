require 'rails_helper'
RSpec.describe Pawn, type: :model do
  it 'will check if a pawn\'s first move is valid' do
    game = FactoryBot.create(:game)
    pawn = FactoryBot.create(:pawn, x_position: 6, y_position: 1, color: :white, type: :pawn, game: game)
    expect(pawn.valid_move?(6, 1)).to eq true
    expect(pawn.valid_move?(6, 2)).to eq true
    expect(pawn.valid_move?(6, 3)).to eq true
    expect(pawn.valid_move?(6, 0)).to eq false
    expect(pawn.valid_move?(6, 4)).to eq false
    expect(pawn.valid_move?(7, 1)).to eq false

    pawn2 = FactoryBot.create(:pawn, x_position: 6, y_position: 6, color: :black, type: :pawn, game: game)
    expect(pawn2.valid_move?(6, 6)).to eq true
    expect(pawn2.valid_move?(6, 5)).to eq true
    expect(pawn2.valid_move?(6, 4)).to eq true
    expect(pawn2.valid_move?(6, 3)).to eq false
    expect(pawn2.valid_move?(6, 7)).to eq false
    expect(pawn2.valid_move?(7, 6)).to eq false
  end

  it 'will check if a pawn\'s move is valid' do
    game = FactoryBot.create(:game)
    pawn = FactoryBot.create(:pawn, x_position: 3, y_position: 4, color: :white, type: :pawn, game: game)
    expect(pawn.valid_move?(3, 4)).to eq true
    expect(pawn.valid_move?(3, 5)).to eq true
    expect(pawn.valid_move?(3, 6)).to eq false
    expect(pawn.valid_move?(3, 3)).to eq false
    expect(pawn.valid_move?(4, 4)).to eq false

    pawn2 = FactoryBot.create(:pawn, x_position: 5, y_position: 5, color: :black, type: :pawn, game: game)
    expect(pawn2.valid_move?(5, 5)).to eq true
    expect(pawn2.valid_move?(5, 4)).to eq true
    expect(pawn2.valid_move?(5, 3)).to eq false
    expect(pawn2.valid_move?(5, 6)).to eq false
    expect(pawn2.valid_move?(6, 5)).to eq false
  end

  it 'will check if a pawn\'s move is obstructed' do
    game = FactoryBot.create(:game)
    pawn = FactoryBot.create(:pawn, x_position: 4, y_position: 4, color: :white, type: :Pawn, game: game)
    FactoryBot.create(:piece, x_position: 4, y_position: 5, color: :black, type: :Queen, game: game)
    expect(pawn.valid_move?(4, 5)).to eq 'occupied'

    pawn2 = FactoryBot.create(:pawn, x_position: 2, y_position: 5, color: :black, type: :Pawn, game: game)
    FactoryBot.create(:piece, x_position: 2, y_position: 4, color: :black, type: :Bishop, game: game)
    expect(pawn2.valid_move?(2, 4)).to eq 'occupied'

    pawn3 = FactoryBot.create(:pawn, x_position: 6, y_position: 3, color: :white, type: :Pawn, game: game)
    FactoryBot.create(:piece, x_position: 6, y_position: 4, color: :white, type: :Rook, game: game)
    expect(pawn3.valid_move?(6, 4)).to eq 'occupied'

    pawn4 = FactoryBot.create(:pawn, x_position: 1, y_position: 7, color: :black, type: :Pawn, game: game)
    FactoryBot.create(:piece, x_position: 1, y_position: 6, color: :white, type: :Knight, game: game)
    expect(pawn4.valid_move?(1, 6)).to eq 'occupied'
  end

  it 'will check if pawn can capture' do
    game = FactoryBot.create(:game)
    pawn = FactoryBot.create(:pawn, x_position: 3, y_position: 3, color: :white, type: :pawn, game: game)
    FactoryBot.create(:piece, x_position: 4, y_position: 4, color: :black, type: :Bishop, game: game)
    expect(pawn.valid_move?(4, 4)).to eq true

    pawn2 = FactoryBot.create(:pawn, x_position: 6, y_position: 5, color: :black, type: :pawn, game: game)
    FactoryBot.create(:piece, x_position: 5, y_position: 4, color: :black, type: :Rook, game: game)
    expect(pawn2.valid_move?(5, 4)).to eq false

    pawn3 = FactoryBot.create(:pawn, x_position: 2, y_position: 3, color: :white, type: :pawn, game: game)
    FactoryBot.create(:piece, x_position: 3, y_position: 2, color: :white, type: :Knight, game: game)
    expect(pawn3.valid_move?(3, 2)).to eq false
  end
end
