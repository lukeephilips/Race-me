class HomeController < ApplicationController
  def index
    @athlete ||= current_user.athlete
    # @friends ||= @client.list_athlete_friends
    @activities ||= current_user.activities

    @users = User.all
    # @hash = Gmaps4rails.build_markers(@activities) do |activity, marker|
    #   marker.lat activity.lat
    #   marker.lng activity.lng
    # end
  end
end
