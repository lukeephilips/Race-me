class RunsController < ApplicationController
  def index
    @user ||= User.find(params[:user_id])
    @runs ||= @user.runs.order(:date).reverse_order.paginate(:page => params[:page], :per_page => 6)
  end

  def show
    @run = Run.find(params[:id])

  end

  def new
    @user = current_user
    @run = @user.runs.new
  end

  def create
    @user = current_user
    @run = @user.runs.new(run_params)

    if @run.save
      # set user_goal join
      @race = @user.races.new(goal_id: @run.goal_id, progress: @run.total_distance.to_i)
      if @race.save
        flash[:notice] = "You're on your way to a new goal"
      else
        # if join already exists update it with new progress,
        current_race = Race.where(goal_id: @run.goal_id, user_id: @user.id ).first
        new_progress = current_race.progress.to_i + @run.total_distance.to_i
        current_race.update({progress: new_progress})
        flash[:notice] = "You're that much closer to your goal"
      end
      redirect_to user_runs_path(current_user)
    else
      flash[:alert] = @run.errors.full_messages.each {|m| m.to_s}.join
      render :new
    end
  end

  def edit
    @user = current_user
    @run = Run.find(params[:id])
  end

  def update
    @user = current_user
    @run = Run.find(params[:id])
    if @run.update(run_params)
      @race = @user.races.new(goal_id: @run.goal_id, progress: @run.total_distance.to_i)
      if @race.save
        flash[:notice] = "You're on your way to a new goal"
      else
        current_race = Race.where(goal_id: @run.goal_id, user_id: @user.id ).first
        new_progress = current_race.progress.to_i + @run.total_distance.to_i
        current_race.update({progress: new_progress})
        flash[:notice] = "You're that much closer to #{@run.goal.name}"
      end

      redirect_to user_goal_path(current_user, @run.goal)
    else
      flash[:alert] = @run.errors.full_messages.each {|m| m.to_s}.join
      render :edit
    end
  end

  def destroy
    @user = current_user
    @run = Run.find(params[:id])
    @run.destroy
    flash[:notice] = "You deleted your run"
    redirect_to user_runs_path(current_user)
  end

  private

  def run_params
    params.require(:run).permit(:start_location, :end_location, :total_time, :total_distance, :travel_method, :goal_id, :date)
  end
end
