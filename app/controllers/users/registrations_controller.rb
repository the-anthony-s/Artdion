module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_user!
    before_action :set_user

    layout 'application', only: %i[edit update email security subscription close]

    def email
      if @user
        render :email
      else
        redirect_to edit_user_registration_path
      end
    end

    def security
      if @user
        @visits = @user.visits.all

        render :security
      else
        redirect_to edit_user_registration_path
      end
    end

    def subscription
      if @user
        render :subscription
      else
        redirect_to edit_user_registration_path
      end
    end

    def close
      if @user
        render :close
      else  
        redirect_to edit_user_registration_path
      end
    end

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
        :current_password, :image, :location, :website,
        :about, :instagram, :twitter, :message, :language,
        :email_announcements, :email_notifications, :email_recommendations,
        :email_tips, :email_updates
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