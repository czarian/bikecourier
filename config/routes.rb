Rails.application.routes.draw do
  namespace :api do
    resources :rides, only: [:create]
    scope :stats do
      get ':period', to: 'stats#index'
    end
  end
end
