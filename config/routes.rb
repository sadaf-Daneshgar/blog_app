Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy, :index]
      resources :likes, only: [:new, :create]
    end
  end

  post "users/:id/generate_token" => "users#generate_token", as: :generate_token

  # Defines the root path route ("/")
  # root "posts#index"
end
