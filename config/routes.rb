Rails.application.routes.draw do
  # scope '/(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
  # end

  # Search controller
  mount Searchjoy::Engine, at: 'searchjoy'
  resource :search, path: '/s', only: :show, controller: :search do
    collection do
      get :autocomplete
    end
  end

  ## Pages ---> Default Controller
  get '/', to: 'pages#index'

  ## Legal ---> Documents: terms, privacy
  get '/privacy', to: 'legal#privacy'
  get '/terms', to: 'legal#terms'

  # Comments
  resources :comments do
    resource :like, module: :comments, only: %i[create destroy]
  end

  # Types
  resources :types, path: 'gallery', only: %i[index show]


  # Users Controller
  devise_for :users, path: 'account', path_names: {
    sing_in: 'login',
    sing_out: 'sign_out',
    sing_up: 'join',
    edit: ''
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
    get 'account/email', to: 'users/registrations#email', as: :email_user_registration
    get 'account/scurity', to: 'users/registrations#security', as: :security_user_registration
    get 'account/subscription', to: 'users/registrations#subscription', as: :subscription_user_registration
    get 'account/close', to: 'users/registrations#close', as: :close_user_registration

    resources :photos, module: :users, only: %i[new create edit update]
  end

  resources :users, path: '' do
    member do
      get '/likes', to: 'users#likes'
    end
    resource :follow, module: :users
  end
  
  # Photos
  resources :photos, path: 'photos', only: %i[index show] do
    resource :like, module: :photos, only: %i[create destroy]
    resources :comments, module: :photos
  end

  # Root
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
