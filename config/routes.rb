Rails.application.routes.draw do
  get 'static/pages'

  root 'static_pages#index'
end
