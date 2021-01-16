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

  devise_scope :user do
    resources :photos, module: :users, only: %i[new create edit update]
  end

  resources :users, path: ''

  # Photos
  resources :photos, path: 'photos', only: %i[index show] do
    resource :like, module: :photos, only: %i[create destroy]
  end

  root 'pages#index'

  # File Upload
  case Rails.configuration.upload_server
  when :s3
    # By default in production we use s3, including upload directly to S3 with
    # signed url.
    mount Shrine.presign_endpoint(:cache) => '/s3/params'
  when :s3_multipart
    # Still upload directly to S3, but using Uppy's AwsS3Multipart plugin
    mount Shrine.uppy_s3_multipart(:cache) => '/s3/multipart'
  when :app
    # In development and test environment by default we're using filesystem storage
    # for speed, so on the client side we'll upload files to our app.
    mount Shrine.upload_endpoint(:cache) => '/upload'
  end

  mount ImageUploader.derivation_endpoint => '/derivations/image'
end
