Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
  root to: 'pages#index'
  resources :products
  resources :categories, only: %i[index show]
end
  get :search, to: 'products#search'
end
