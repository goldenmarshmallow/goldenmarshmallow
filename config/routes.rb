Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#index'
  get 'team', to: 'static_pages#team'
  resources :games, only: %i[new create show index update] do
    put 'forfeit', on: :member
    resources :pieces, only: %i[create show update]
  end
end
