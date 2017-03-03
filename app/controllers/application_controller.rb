class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def token_exchange
    current_user.code = params['code']
    access_information = Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], current_user.code)
    current_user.access_token = access_information['access_token']
    session[:access_token] = current_user.access_token

    current_user.client = Strava::Api::V3::Client.new(:access_token => current_user.access_token)
    session[:athlete] ||= current_user.client.retrieve_current_athlete

    redirect_to root_path
  end
end
