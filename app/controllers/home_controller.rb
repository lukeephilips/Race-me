class HomeController < ApplicationController
  def index
    @athlete ||= current_user.client.retrieve_current_athlete
    # @friends ||= @client.list_athlete_friends
    # @activities ||= @client.list_athlete_activities
  end
end
