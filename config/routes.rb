Rails.application.routes.draw do
  # home page
  root 'products#index'

  get     'users/new'
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  resources :products
  resources :users
end
