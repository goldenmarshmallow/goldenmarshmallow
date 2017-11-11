require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "game#new action" do
    it 'should check the original position of some pieces' do
      game = FactoryBot.create(:game)
      #get :show, params: { id: game.id }

      expect(game.pieces.at(3, 1).to_s).to eq 'Pawn'
      expect(game.pieces.at(1, 0).to_s).to eq 'Knight'
      expect(game.pieces.at(7, 0).to_s).to eq 'Rook'
      expect(game.pieces.at(6, 7).to_s).to eq 'Knight'
      expect(game.pieces.at(6, 6).to_s).to eq 'Pawn'
      expect(game.pieces.at(0, 4).to_s).to eq 'King'
      expect(game.pieces.at(3, 7).to_s).to eq 'Queen'
      expect(game.pieces.at(5, 7).to_s).to eq 'Bishop'
      expect(game.pieces.at(2, 0).to_s).to eq 'Bishop'
    end
  end
end
