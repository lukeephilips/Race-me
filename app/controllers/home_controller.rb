class HomeController < ApplicationController
  def index
    @athlete ||= current_user.athlete
    # @friends ||= @client.list_athlete_friends
    @activities ||= current_user.activities
    @users = User.all

    if user_signed_in? && current_user.runs.empty?
      current_user.activities.first(10).each do |activity|
        current_user.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'])
        puts "RUNS CREATED"
      end
    end

  end
end
