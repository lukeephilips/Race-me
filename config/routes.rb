Rails.application.routes.draw do
  root to: "goals#index"
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :home, only: [:index]
  resources :users do
    resources :runs
    resources :goals
  end
end
