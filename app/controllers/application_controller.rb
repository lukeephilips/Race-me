class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!






  # def token_exchange
  #   @code = params['code']
  #   access_information = Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], @code)
  #   @access_token = access_information['access_token']
  #   current_user.client = Strava::Api::V3::Client.new(:access_token => @access_token)
  #   current_user.athlete ||= current_user.client.retrieve_current_athlete
  #   current_user.activities ||= current_user.client.list_athlete_activities
  #   redirect_to '/'
  # end
end
