class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # @client = Strava::Api::V3::Client.new(:access_token => ENV['ACCESS_TOKEN'])

end
