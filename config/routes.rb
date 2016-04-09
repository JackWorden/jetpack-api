Rails.application.routes.draw do
  resources :projects, except: [:new, :edit]
  resources :teams, except: [:new, :edit]

  resources :users do
    collection do
      get 'from_token'
    end
  end
end
