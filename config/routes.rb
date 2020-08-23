Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # fechar as rotas para não usar todas
  resources :car_categories
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update ]
  resources :car_models, only: [:index, :show, :new, :create]
  resources :customers, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :show, :new, :create]
end
