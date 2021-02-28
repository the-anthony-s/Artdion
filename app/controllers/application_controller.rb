class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception

  # after_action :track_action

  before_action :store_user_location!, if: :storable_location?
  before_action :set_locale
  # before_action :default_format_html

  # Set user's prefered locale (website translation)
  def set_locale
    return I18n.locale = current_user.language if user_signed_in? && current_user.language?

    I18n.locale = extract_locale_from_headers
  end

  # Get current timezone
  def set_time_zone
    if user_signed_in?
      Time.zone = current_user.time_zone
    else
      browser_time_zone
    end
  end

  def browser_time_zone
    browser_tz = ActiveSupport::TimeZone.find_tzinfo(cookies[:browser_time_zone])
    ActiveSupport::TimeZone.all.find { |zone| zone.tzinfo == browser_tz } || Time.zone
  rescue TZInfo::UnknownTimezone, TZInfo::InvalidTimezoneIdentifier
    Time.zone
  end

  # Return user back after login
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer || super
  end

  private

  # Get user's locale from headers
  def default_url_options(_options = {})
    { locale: nil }
  end

  ALLOWED_LOCALES = %w[( en ru )].freeze
  DEFAULT_LOCALES = 'en'.freeze

  def extract_locale_from_headers
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    if ALLOWED_LOCALES.include?(browser_locale)
      browser_locale
    else
      DEFAULT_LOCALE
    end
  end

  protected

  # Track users' actions
  # Not using it due to a lack of performance
  def track_action
    ahoy.track 'Ran action', request.path_parameters
  end
end
