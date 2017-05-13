class HomeController < ApplicationController
  def index
    @user = current_user
    if @user.runs.any?
      @runs ||= @user.runs.where(goal_id: nil).paginate(:page => params[:page], :per_page => 6)
    end

    if !@user.token
      flash[:notice] = "Welcome! First things first, login to your strava account in the navbar"
    elsif !@user.runs
      flash[:notice] = "Looks like you don't have any new runs on strava. Go to Runs in the navbar to manually enter one"
    elsif @runs && @user.races.empty?
      flash[:notice] = "Next up, create a Goal"
    elsif @runs
      flash[:notice] = "Assign your new runs to an active goal to move along your virtual route"
    end

  end
end
