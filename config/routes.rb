Rails.application.routes.draw do
  get '/', to: 'pages#index'

  root 'pages#index'
end
