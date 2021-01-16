module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_user!
    # before_action :set_user, only: %i[preferences security]

    layout 'application', only: %i[edit update preferences security]

    private

    def set_user
      @user = current_user
    end

    def sign_up_params
      params.require(:user).permit(
        :username, :first_name, :last_name,
        :email, :password, :password_confirmation
      )
    end

    def account_update_params
      params.require(:user).permit(
        :username, :first_name, :last_name,
        :email, :password, :password_confirmation,
        :current_password, :image
      )
    end

    protected

    def update_resource(resource, params)
      # Require current password if user is trying to change password.
      return super if params['password']&.present?

      # Allows user to update registration information without password.
      resource.update_without_password(params.except('current_password'))
    end

    def after_update_path_for(resource)
      flash[:notice] = 'Account updated'
      request.referrer || edit_user_registration_path
    end
  end
end