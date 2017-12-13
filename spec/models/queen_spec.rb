require 'rails_helper'
RSpec.describe Queen, type: :model do
  it 'will check if a queen\'s move is valid' do
    game = FactoryBot.create(:game)
    queen = FactoryBot.create(:queen, x_position: 3, y_position: 0, color: :white, type: :queen, game: game)
    expect(queen.valid_move?(3, 0)).to eq true
    expect(queen.valid_move?(4, 2)).to eq false
    expect(queen.valid_move?(7, 4)).to eq true

    queen = FactoryBot.create(:queen, x_position: 5, y_position: 4, color: :white, type: :queen, game: game)
    expect(queen.valid_move?(7, 5)).to eq false
    expect(queen.valid_move?(1, 3)).to eq false
    expect(queen.valid_move?(7, 6)).to eq true
  end
end
