class HomeController < ApplicationController
  def index
    if current_user.token
      @client = Strava::Api::V3::Client.new(:access_token => current_user.token)
      @athlete ||= @client.retrieve_current_athlete
      @activities ||= @client.list_athlete_activities
      @users = User.all

      if current_user.runs.empty?
        # current_user.activities.first(20).each do |activity|
        #   current_user.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'], date: Time.parse(activity['start_date_local']))
        #   puts "RUNS CREATED"
        # end
      # else
        # # up_to_date = false
        # # while up_to_date == false
        # # current_user.each do |activity|
        # #   if Run.allactivity['id'])
        # end

        # end
      end
    end
  end
end
