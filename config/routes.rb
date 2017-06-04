Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, :controllers => {
    registrations: 'registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
    }
  resources :home, only: [:index, :update]
  resources :users do
    resources :runs
    resources :goals
  end
  get '/token_exchange', to: 'application#token_exchange'

  devise_scope :user do
   get '/sign_up/:goal_id', to: 'registrations#new', as: :new_invite
  end
end
