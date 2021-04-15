# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/game', to: 'pages#game'

  get '/rooms', to: 'game_rooms#index'
  post 'guest', to: 'application#guest_login'
  resources :users do
    
      get :new_guest
    
  end
  resources :game_rooms do
    member do
      get :join_match
      get :leave
    end
  end
end
