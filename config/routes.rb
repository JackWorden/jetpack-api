Rails.application.routes.draw do
  resources :projects, except: [:edit, :new] do
    member do
      get 'sprints'
    end
  end

  resources :stories, except: [:edit, :new, :index]

  resources :users do
    collection do
      post 'from_token'
    end
  end

  resource :teams, only: [:show, :create, :destroy]

  resources :sprints, except: [:edit, :new] do
    member do
      post 'activate'
      post 'deactivate'
    end
  end

  resources :issues, except: [:edit, :new]
end
