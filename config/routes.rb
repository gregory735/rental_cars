Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  # fechar as rotas para não usar todas
  resources :car_categories, only: [ :index, :show, :new, :create ]
  resources :subsidiaries, only: [ :index, :show, :new, :create ]
  
end
