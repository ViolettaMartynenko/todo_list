Rails.application.routes.draw do
  resources :lists do
    resources :tasks, only: [:create, :new, :edit, :update, :destroy] do
      member do
        patch 'completeness'
      end
    end
  end
  root to: 'lists#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
