Rails.application.routes.draw do
  resources :projects, except: [:edit, :new]

  resources :users do
    collection do
      get 'from_token'
    end
  end

  resource :teams, only: [:show, :create, :destroy]
  resources :sprints, only: [:show, :create, :update, :destroy, :index] do
    member do
      post 'activate'
      post 'deactivate'
    end
  end
end
