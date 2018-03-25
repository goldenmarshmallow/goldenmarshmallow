require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'When a new game is created' do
    it 'will generate all the pieces in their correct positions' do
      game = FactoryBot.create(:game)
      game.populate_board

      expect(game.pieces.find_by(x_position: 3, y_position: 1).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 1, y_position: 0).type).to eq 'Knight'
      expect(game.pieces.find_by(x_position: 7, y_position: 0).type).to eq 'Rook'
      expect(game.pieces.find_by(x_position: 6, y_position: 7).type).to eq 'Knight'
      expect(game.pieces.find_by(x_position: 6, y_position: 6).type).to eq 'Pawn'
      expect(game.pieces.find_by(x_position: 4, y_position: 0).type).to eq 'King'
      expect(game.pieces.find_by(x_position: 3, y_position: 7).type).to eq 'Queen'
      expect(game.pieces.find_by(x_position: 5, y_position: 7).type).to eq 'Bishop'
      expect(game.pieces.find_by(x_position: 2, y_position: 0).type).to eq 'Bishop'
    end

    it 'will declare black player as a winner if the white player forfeits' do
      white_player = FactoryBot.create(:user)
      black_player = FactoryBot.create(:user)
      game = FactoryBot.create(:game, white_player: white_player, black_player: black_player)
      game.forfeit(white_player)
      game.update_attributes(winner_id: black_player.id)
      expect(game.winner_id).to eq black_player.id
    end

    it 'will declare white player as a winner if the black player forfeits' do
      white_player = FactoryBot.create(:user)
      black_player = FactoryBot.create(:user)
      game = FactoryBot.create(:game, white_player: white_player, black_player: black_player)
      game.forfeit(black_player)
      game.update_attributes(winner_id: white_player.id)
      expect(game.winner_id).to eq white_player.id
    end
  end

  context 'Check if a game has a check status' do
    it 'will correctly show the game is in check if the King is at the opponent\'s destination' do
      game = FactoryBot.create(:game)
      king = FactoryBot.create(:piece, x_position: 4, y_position: 4, color: :white, type: :King, game: game)
      queen = FactoryBot.create(:piece, x_position: 1, y_position: 3, color: :black, type: :Queen, game: game)
      queen.move_to!(2, 4)
      queen.reload
      king.reload
      expect(game.check?).to eq true
    end

    it 'will not show the game is in check if the King is not at the opponent\'s destination' do
      game = FactoryBot.create(:game)
      king = FactoryBot.create(:piece, x_position: 4, y_position: 4, color: :white, type: :King, game: game)
      queen = FactoryBot.create(:piece, x_position: 1, y_position: 3, color: :black, type: :Queen, game: game)
      queen.move_to!(0, 2)
      queen.reload
      king.reload
      expect(game.check?).to eq false
    end
  end
end
