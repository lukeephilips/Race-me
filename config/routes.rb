Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :home, only: [:index]
  resources :users do
    resources :runs
    resources :goals
  end

end
