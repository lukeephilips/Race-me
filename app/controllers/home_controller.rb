class HomeController < ApplicationController
  def index
    @user ||= current_user
    if @user.goals.any?
      @goals ||= @user.goals
    end
    if @user.runs.any?
      @runs ||= current_user.runs.where(goal_id: nil)
    end
    # if !@user.token
    #   flash[:notice] = "Welcome! First things first, login to your strava account in the navbar"
    # elsif !@runs
    #   flash[:notice] = "Looks like you don't have any new runs on strava. Go to Runs in the navbar to manually enter one"
    # elsif @runs && current_user.races.empty?
    #   flash[:notice] = "Next up, create a Goal"
    # elsif @runs
    #   flash[:notice] = "Assign your runs to an active goal using the dropdown menus to move along your virtual route"
    # end

    # if current_user.token
    #   @client = Strava::Api::V3::Client.new(:access_token => current_user.token)
    #   @athlete ||= @client.retrieve_current_athlete
    # end
  end
end
