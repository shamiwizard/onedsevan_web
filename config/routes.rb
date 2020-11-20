Rails.application.routes.draw do
  namespace :panel do
    resources :games
  end

  devise_for :users

  root to: 'public#index'
end
