class RunsController < ApplicationController
  def index
    @runs = current_user.runs
  end
  def show
    @run = Run.find(params[:id])
    byebug
  end

  def new
    @user = current_user
    @run = @user.runs.new
  end

  def create
    @user = current_user
    @run = @user.runs.new(run_params)
    if @run.save
      flash[:notice] = "You saved your run"
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
