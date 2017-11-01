Rails.application.routes.draw do
  devise_for :users
  # get 'static/pages'

  root 'static_pages#index'
end
