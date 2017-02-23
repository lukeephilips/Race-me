class RunsController < ApplicationController
  def index
    @runs = current_user.runs
    @goals = current_user.goals
  end

  def show
    @run = Run.find(params[:id])

  end

  def new
    @user = current_user
    @run = @user.runs.new
    @goals = Goal.all.collect{|goal| [goal.name, goal.id]}
  end

  def create
    @user = current_user
    @run = @user.runs.new(run_params)
    if @run.save
      @race = @user.races.new(goal_id: @run.goal_id, progress: @run.total_distance.to_i)
      if @race.save
        flash[:notice] = "You're on your way to a new goal"
      else
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
    @goals = Goal.all.collect{|goal| [goal.name, goal.id]}
    @user = current_user
    @run = Run.find(params[:id])
  end

  def update
    @user = current_user
    @run = Run.find(params[:id])
    if @run.update(run_params)
      flash[:notice] = "You edited your run"
      redirect_to user_runs_path(current_user)
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
    params.require(:run).permit(:start_location, :end_location, :total_time, :total_distance, :travel_method, :goal_id)
  end
end
