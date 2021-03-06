Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :posts
  resources :users
  resources :comments
  resources :conversations
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
