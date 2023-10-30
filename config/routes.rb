Rails.application.routes.draw do
  devise_for :users
  root to: "cards#index"

  resources :cards, only: [:index, :show]

  resources :trades do
    resources :requests, only: [:new, :create], shallow: true
  end

  resources :requests, only: [:destroy]

  resources :collections, shallow: true do
    post 'add_to_collection', on: :collection
    delete 'remove_from_collection', on: :member
    resources :cards, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :wantlists, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  post 'wantlists/add_to_wantlist', to: 'wantlists#add_to_wantlist', as: 'add_to_wantlist_wantlists'

  resources :trade_items, only: [:index, :show]

  resources :users, only: [] do
    resources :collections, only: [:index, :show], controller: 'users/collections'
    resources :trades, only: [:index, :show], controller: 'users/trades'
  end

  get '/search', to: 'application#search'

  patch "/requests/:id/accept", to: "requests#accept", as: "accept"
  patch "/requests/:id/reject", to: "requests#reject", as: "reject"
end
