class HomeController < ApplicationController
  def index
    @athlete ||= current_user.athlete
    # @friends ||= @client.list_athlete_friends
    @activities ||= current_user.activities

    @users = User.all
  end
end
