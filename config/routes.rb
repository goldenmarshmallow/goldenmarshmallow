Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#index'
  resources :games, only: %i[new create show index update] do
    post 'forfeit', on: :member
    resources :pieces, only: %i[create show update]
  end
end
