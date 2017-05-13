class HomeController < ApplicationController
  def index
    @user = current_user
    if @user.runs.any?
      @runs ||= @user.runs.where(goal_id: nil).paginate(:page => params[:page], :per_page => 6)
    end
    flash[:notice] = current_user.walkthrough
  end
end
