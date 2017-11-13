require 'rails_helper'
RSpec.describe Piece, type: :model do
  it 'will check if a piece is obstructed' do
    game = FactoryBot.create(:game)
    expect(game.pieces.at(3, 1).obstructed?(3, 3)).to eq false
    expect(game.pieces.at(0, 0).obstructed?(0, 4)).to eq true
    expect(game.pieces.at(0, 7).obstructed?(2, 7)).to eq true
    expect(game.pieces.at(1, 0).obstructed?(2, 2)).to eq 'Invalid Input'
  end
end
