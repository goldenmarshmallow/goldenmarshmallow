require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'game#new action' do
    it 'should require users to be logged in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully show the new form' do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'game#index action' do
    it 'should successfully display available games' do
      game = FactoryBot.create(:game)
      white_player = FactoryBot.create(:user)
      get :index, params: { name: game.name }
      expect(white_player).not_to eq nil
      expect(response).to have_http_status(:success)
    end
  end

  describe 'game#create action' do
    it 'should require users to be logged in' do
      post :create, params: { game: { name: 'Hello' } }
      expect(response).to redirect_to new_user_session_path
    end

    it 'should successfully create a new game in our database' do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { game: { name: 'Chess' } }
      expect(response).to redirect_to game_path(Game.last)

      game = Game.last
      expect(game.name).to eq('Chess')
      expect(game.user).to eq(user)
    end

    it 'should properly deal with validation errors' do
      user = FactoryBot.create(:user)
      sign_in user

      game_count = Game.count
      post :create, params: { game: { name: ' ' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(game_count).to eq Game.count
    end
  end

  describe 'game#show action' do
    it 'should successfully show the page if the game is found' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)

      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

    it 'should return a 404 error if the game is not found' do
      user = FactoryBot.create(:user)
      sign_in user

      get :show, params: { id: 'BLANK' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
