class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def token_exchange
    code = params['code']
    access_information = Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], code)
    access_token = access_information['access_token']
    current_user.update({token: access_token})
    
    if current_user.token && current_user.runs.empty?
      @client = Strava::Api::V3::Client.new(:access_token => current_user.token)
      @activities ||= @client.list_athlete_activities

      @activities.first(20).each do |activity|
        current_user.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'], date: Time.parse(activity['start_date_local']))
        puts "RUNS CREATED"
      end
    end

    redirect_to root_path
  end
end
