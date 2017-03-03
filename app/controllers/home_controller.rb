class HomeController < ApplicationController
  def index
    if session[:access_token]
      current_user.access_token ||= session[:access_token]
      @access_token ||= session[:access_token]

      current_user.client = Strava::Api::V3::Client.new(:access_token => current_user.access_token)
      @athlete ||= current_user.client.retrieve_current_athlete
      @activities ||= current_user.client.list_athlete_activities


      @users = User.all

      if user_signed_in? && current_user.client && current_user.runs.empty?
      current_user.activities.first(10).each do |activity|
        current_user.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'])
        puts "RUNS CREATED"
      end
      end
    end
  end
end
