Rails.application.routes.draw do
  # all user authentication logic, using gem devise
  devise_for :users

  # application related user logic
  get 'user/account', to: 'users#show', as: 'account'

  # show details for specified order
  get 'order/:id', to: 'orders#show', as: 'order'

  resources :items do
    resources :bids
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => redirect('/items')
end
