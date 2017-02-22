class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    byebug
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :admin, :avatar, :avatar_cache)
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :current_password, :admin, :avatar)
  end
end
