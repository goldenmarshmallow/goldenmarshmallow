require 'rails_helper'
RSpec.describe King, type: :model do
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
    king = FactoryBot.create(:king, x_position: 2, y_position: 4, color: :white, type: :king, game: game)
    expect(king.valid_move?(1, 3)).to eq true
  end
end
