require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'pieces#show action' do
    it 'should authenticate a user in order to see the piece page' do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      get :show, params: { game_id: game.id, id: piece.id }
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully show the pieces page if a user is logged in' do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      user = FactoryBot.create(:user)
      sign_in user

      get :show, params: { game_id: game.id, id: piece.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'pieces#update action' do
    it 'should authenticate a user in order to update a piece' do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)

      patch :update, params: { game_id: game.id, id: piece.id }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
