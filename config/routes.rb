Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'comments/update'
  get 'comments/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  resources :users, only: [:index, :show, :new, :edit, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]

  resources :users, shallow: true do
    resources :tweets do
      resources :comments, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :users do
    member do
     get :followings, :followers
    end
  end

  match 'signup', to: 'users#new', via: 'get'
  match 'signin', to: 'sessions#new', via: 'get'
  match 'signout', to: 'sessions#destroy', via: 'delete'

  root 'users#index'
end
