Rails.application.routes.draw do
  namespace :panel do
    get '/', to: 'menu#index'
    resources :games
  end

  devise_for :users

  root to: 'public#index'
end
