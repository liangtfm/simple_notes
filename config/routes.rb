JournalApp::Application.routes.draw do
  root to: 'sessions#new'

  resources :posts, :only => [:index, :create, :show, :update, :destroy]

  resources :users, :except => [:destroy] do
    get 'activate'
  end

  resource :session, :only => [:create, :destroy, :new]

  post "inbound/twilio" => "inbound#twilio"
end
