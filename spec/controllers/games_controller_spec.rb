require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'game#new action' do
    it 'should successfully show the new form' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'game#create action' do
    it 'should successfully create a new game in our database' do
      post :create, params: { game: { name: 'Chess' } }
      expect(response).to redirect_to root_path

      game = Game.last
      expect(game.name).to eq('Chess')
    end

    it 'should properly deal with validation errors' do
      get :create, params: { game: { name: ' ' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Game.count).to eq 0
    end
  end

  describe 'game#show action' do
    it 'should successfully show the page if the game is found' do
      game = FactoryBot.create(:game)
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it 'should return a 404 error if the game is not found' do
      get :show, params: { id: 'BLANK' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
