require 'rails_helper'
RSpec.describe Knight, type: :model do
  it 'will check if a knight\'s move is valid' do
    game = FactoryBot.create(:game)
    knight = FactoryBot.create(:knight, x_position: 3, y_position: 3, color: :black, type: :knight, game: game)
    # Moving the Knight upward
    expect(knight.valid_move?(5, 4)).to eq true
    expect(knight.valid_move?(5, 5)).to eq false
    expect(knight.valid_move?(1, 4)).to eq true
    expect(knight.valid_move?(2, 2)).to eq false
    expect(knight.valid_move?(4, 5)).to eq true
    expect(knight.valid_move?(4, 6)).to eq false
    expect(knight.valid_move?(2, 5)).to eq true
    expect(knight.valid_move?(3, 5)).to eq false
    # Moving the Knight downward
    expect(knight.valid_move?(1, 2)).to eq true
    expect(knight.valid_move?(1, 1)).to eq false
    expect(knight.valid_move?(5, 2)).to eq true
    expect(knight.valid_move?(5, 1)).to eq false
    expect(knight.valid_move?(4, 1)).to eq true
    expect(knight.valid_move?(4, 0)).to eq false
    expect(knight.valid_move?(2, 1)).to eq true
    expect(knight.valid_move?(2, 2)).to eq false
  end
end
