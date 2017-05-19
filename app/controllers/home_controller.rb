class HomeController < ApplicationController
  def index
    @user = User.includes(:runs, :races, :goals).find(current_user.id)
    if @user.runs.any?
      @runs = @user.runs.where(goal_id: nil).order(:date).reverse_order.paginate(:page => params[:page], :per_page => 6)
    end
    unless session[:walkthrough].present?
      flash.now[:notice] = current_user.walkthrough
      session[:walkthrough] = true
    end
  end
end
