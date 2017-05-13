class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def current_user
    @current_user ||= super && User.includes(:goals, :runs, :races).find(@current_user.id)
  end

  def token_exchange
    code = params['code']
    access_information =  Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], code)
    access_token = access_information['access_token']

    if access_information['athlete']['profile_medium'].present?
      profile_picture = access_information['athlete']['profile_medium']
    else
      profile_picture = nil
    end

    current_user.update({
      token: access_token,
      profile_picture: profile_picture})

    current_user.check_for_token_and_runs

    redirect_to root_path
  end
end
