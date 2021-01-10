Rails.application.routes.draw do
  ## Pages ---> Default Controller
  get '/', to: 'pages#index'

  # Users Controller
  devise_for :users, path: 'account', path_names: {
    sing_in: 'sign_in',
    sing_out: 'sign_out',
    sing_up: 'sign_up',
    edit: 'settings'
  }, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    invitations: 'users/invitations',
    # omniauth_callbacks: 'sellers/omniauth_callbacks',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  # devise_scope :user do
  #   resources :photos, module: :users, only: %i[new create edit update]
  # end

  resources :users, path: ''

  root 'pages#index'
end
