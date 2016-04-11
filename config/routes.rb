Rails.application.routes.draw do
  resources :users, only: [:show] do
    collection do
      get 'from_token'
    end
  end

  resource :teams, only: [:show, :create, :destroy]
end
