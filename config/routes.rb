Rails.application.routes.draw do
  get "welcome/index"
  devise_for :users

  resources :expenses do
    member do
      patch :toggle_paid
      get 'confirm_destroy'
      delete 'destroy_all_recurrences'
      
    end

    collection do
      get :report
      delete 'clear_all', to: 'expenses#clear_all', as: 'clear_all'
      get :list_expenses
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  get '/dashboard', to: 'dashboard#show', as: 'dashboard'
  
  # Raiz do sistema
  root to: 'welcome#index'
end
