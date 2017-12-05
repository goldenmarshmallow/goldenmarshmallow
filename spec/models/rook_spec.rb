require 'rails_helper'
RSpec.describe Rook, type: :model do
  it 'will check if a rook\'s move is valid' do
    game = FactoryBot.create(:game)
    rook = FactoryBot.create(:rook, x_position: 0, y_position: 0, color: :white, type: :rook, game: game)
    expect(rook.valid_move?(3, 0)).to eq true
    expect(rook.valid_move?(3, 3)).to eq false
    expect(rook.valid_move?(0, 7)).to eq true

    rook = FactoryBot.create(:rook, x_position: 2, y_position: 3, color: :white, type: :rook, game: game)
    expect(rook.valid_move?(6, 3)).to eq true
    expect(rook.valid_move?(4, 5)).to eq false
    expect(rook.valid_move?(2, 6)).to eq true
  end
end
