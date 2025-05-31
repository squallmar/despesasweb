Rails.application.routes.draw do
  devise_for :users

  resources :expenses do
    member do
      patch :toggle_paid
    end

    collection do
      get :report
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Raiz do sistema
  root to: 'expenses#index'
end
