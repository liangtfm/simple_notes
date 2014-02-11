JournalApp::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, only: [:index, :create, :show, :update]
end
