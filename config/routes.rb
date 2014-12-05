Rails.application.routes.draw do

  # home page
  root 'products#index'

  get     'cart'          => 'users#cart'
  get     'signup'        => 'users#new'
  get     'login'         => 'sessions#new'
  delete  'logout'        => 'sessions#destroy'
  post    'login'         => 'sessions#create'
  post    'products/:id'  => 'products#add_to_basket'

  resources :products
  resources :basketpositions
  resources :users
end
