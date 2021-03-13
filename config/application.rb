require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Art
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Use SuckerPunch for background jobs.
    config.active_job.queue_adapter = :sucker_punch

    config.autoload_paths += %w[lib]

    # supports :s3, :s3_multipart, or :app
    config.upload_server = if ENV['UPLOAD_SERVER'].present?
                             ENV['UPLOAD_SERVER'].to_sym
                           elsif Rails.env.production?
                             :s3
                           else
                             :s3
                            #  :app
                           end

    config.imgix = {
      use_https: true,
      source: 'artdion.imgix.net',
      secure_url_token: 'gtVrV6dParFc9stC'
    }

    # Change default locale structure
    config.i18n.fallbacks = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Default timezone
    # config.time_zone = 'Central Time (US & Canada)'
    # config.active_record.default_timezone = :utc
  end
end
