Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index', as: :root
  get '/auth/google_oauth2', as: :google_oauth2
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :recipes, only: [:new, :index]
  resources :challenges, only: [:index, :show]

  namespace :users do
    get '/hints', to: 'games#hints'
  end

  scope :users, module: :users do
    resources :dashboard, only: :index
    resources :ingredients, except: [:new, :show, :edit]
    resources :challenges, except: :destroy
    resources :ratings, only: :create
    resources :photos, only: :create
  end
end
