class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters


  def new
      build_resource({})
      yield resource if block_given?
      respond_with resource
      flash[:notice] = ""
    end

    def create

    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if params[:goal_id].present?
        resource.goals.push(Goal.find(params[:goal_id]))
      end
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :password, :password_confirmation, :goal_id])
  end

  def sign_up_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :goal_id)
  end

  def account_update_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :current_password, :admin, :avatar)
  end
end
