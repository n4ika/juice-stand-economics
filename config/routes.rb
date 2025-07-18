Rails.application.routes.draw do  # your “root” goes inside this block
  root "home#index"

  resources :juices do
    post :sell, on: :member
  end

  resources :transactions, only: [:index, :show]
  resources :customers

  resource :economy, only: [:show] do
  post :reset, on: :member
  end

  resources :market_events, only: :index

end
