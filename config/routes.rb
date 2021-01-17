Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
  root to: 'pages#index'
  resources :products
  resources :categories, only: %i[index show]
end
get '/admin/products/import', to: 'admin/products#import'
  post '/admin/products/import', to: 'admin/products#import_file'
  get :search, to: 'products#search'
  resource :call_me, only: %i[create], controller: :call_me
  ActiveAdmin.routes(self)
 end
