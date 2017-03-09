class HomeController < ApplicationController
  def index
    @user = current_user
    if @user.goals.any?
      @goals = @user.goals
    end
    if @user.runs.any?
      @runs ||= current_user.runs.where(goal_id: nil)
    end
    if current_user.token
      @client = Strava::Api::V3::Client.new(:access_token => current_user.token)
      @athlete ||= @client.retrieve_current_athlete
    end
  end
end
