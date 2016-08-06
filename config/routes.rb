Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: :index do
    resources :comments
  end

end
