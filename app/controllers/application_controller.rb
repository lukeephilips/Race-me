class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def token_exchange
    code = params['code']
    access_information = Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], code)
    byebug
    access_token = access_information['access_token']
    current_user.update({token: access_token})

    redirect_to root_path
  end
end
