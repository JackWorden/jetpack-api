Rails.application.routes.draw do
  resources :projects, except: [:edit, :new]

  resources :stories, except: [:edit, :new, :index]

  resources :users do
    collection do
      get 'from_token'
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
