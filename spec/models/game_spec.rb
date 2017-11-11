require 'rails_helper'

RSpec.describe Game, type: :model do
  context "When a new game is created" do
    it 'will generate all the pieces in their correct positions' do
      game = FactoryBot.create(:game)

      expect(game.pieces.at(3, 1).type).to eq 'Pawn'
      expect(game.pieces.at(1, 0).type).to eq 'Knight'
      expect(game.pieces.at(7, 0).type).to eq 'Rook'
      expect(game.pieces.at(6, 7).type).to eq 'Knight'
      expect(game.pieces.at(6, 6).type).to eq 'Pawn'
      expect(game.pieces.at(4, 0).type).to eq 'King'
      expect(game.pieces.at(3, 7).type).to eq 'Queen'
      expect(game.pieces.at(5, 7).type).to eq 'Bishop'
      expect(game.pieces.at(2, 0).type).to eq 'Bishop'
    end
  end
end
