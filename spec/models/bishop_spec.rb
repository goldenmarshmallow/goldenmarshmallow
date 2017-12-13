require 'rails_helper'
RSpec.describe Bishop, type: :model do
  describe 'will create a game' do
    game = FactoryBot.create(:game)

    it 'will check if a bishop move from (4,3) to (7,6) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 4, y_position: 3, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(7, 6)).to eq true
    end

    it 'will check if a bishop move from (4,3) to (7,1) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 4, y_position: 3, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(7, 1)).to eq false
    end

    it 'will check if a bishop move from (4,3) to (1,0) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 4, y_position: 3, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(1, 0)).to eq true
    end

    it 'will check if a bishop move from (4,3) to (7,0) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 4, y_position: 3, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(7, 0)).to eq true
    end

    it 'will check if a bishop move from (5,0) to (7,2) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 5, y_position: 0, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(7, 2)).to eq true
    end

    it 'will check if a bishop move from (5,0) to (7,3) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 5, y_position: 0, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(7, 3)).to eq false
    end

    it 'will check if a bishop move from (2,0) to (0,2) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 2, y_position: 0, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(0, 2)).to eq true
    end

    it 'will check if a bishop move from (2,4) to (5,7) is valid' do
      bishop = FactoryBot.create(:bishop, x_position: 2, y_position: 4, color: :white, type: :bishop, game: game)
      expect(bishop.valid_move?(5, 7)).to eq true
    end
  end
end
