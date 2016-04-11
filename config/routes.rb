Rails.application.routes.draw do
  resources :projects
  post "projects/:id/edit", to: "projects#edit"
  post "projects/new", to: "projects#new"

  resources :users do
    collection do
      get 'from_token'
    end
  end

  resource :teams, only: [:show, :create, :destroy]
end
