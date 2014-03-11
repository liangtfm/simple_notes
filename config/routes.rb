JournalApp::Application.routes.draw do
  root to: 'sessions#new'

  resources :posts, only: [:index, :create, :show, :update]

  resources :users, :only => [:create, :new, :show, :edit, :update, :index]

  resource :session, :only => [:create, :destroy, :new]
end
