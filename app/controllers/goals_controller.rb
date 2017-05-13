class GoalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:search_term]
      @goals = @user.goals.basic_search(params[:search_term])
    else
      @goals = @user.goals.all.paginate(:page => params[:page], :per_page => 4)
    end

    respond_to do |format|
      format.js
      format.html {render :index}
    end
  end

  def show
    @goal = Goal.find(params[:id])

    @users_races_hash = @goal.users.map do |user|
      Hash["name" => user.name, "distance" => user.races.where(goal_id: @goal.id).first.progress]
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    # collect user input and make calls to GMaps geotagging
    user_total_distance = Geocoder.get_distance(Geocoder.get_geo(goal_params[:start_location]), Geocoder.get_geo(goal_params[:end_location]))['rows'][0]['elements'][0]['distance']['value']

    @goal = Goal.new({name: goal_params[:name],
                      start_location: goal_params[:start_location],
                      end_location: goal_params[:end_location],
                      start_latlng: Geocoder.get_geo(goal_params[:start_location]),
                      end_latlng: Geocoder.get_geo(goal_params[:end_location]),
                      total_distance: user_total_distance})
    @goals = Goal.all.collect{|goal| [goal.name, goal.id]}

    if @goal.save
      # create user_goal join

      current_user.races.create(goal_id: @goal.id, progress: 0)
      @flash_message = "You saved #{@goal.name}"

      if params[:opponents] != ''
        invite_opponents(params[:opponents].split(", "))
      end

      flash[:notice] = @flash_message
      redirect_to user_goal_path(current_user,@goal)
    else
      flash[:alert] = @goal.errors.full_messages.each {|m| m.to_s}.join
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    @goals = current_user.goals.collect{|goal| [goal.name, goal.id]}

  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      flash[:notice] = "You edited #{@goal.name}"
      redirect_to user_goals_path(current_user)
    else
      flash[:alert] = @goal.errors.full_messages.each {|m| m.to_s}.join
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "You deleted #{@goal.name}"
    redirect_to user_goals_path(current_user)
  end

  private

  def goal_params
    if params[:search_term]
    else
      params.require(:goal).permit(:start_location, :end_location, :name, :total_distance, :ajax_flag)
    end
  end

  def invite_opponents(opponents)
    opponents.each do |invited_opponent|
      stripped_opponent = invited_opponent.strip
      if User.exists?(email: stripped_opponent)
        invited_user = User.find_by(email: stripped_opponent)
        invited_user.races.create(user_id: invited_user.id, goal_id: @goal.id, progress: 0)
        @flash_message += "\n"+"and invited " + invited_user.email
      else
        @flash_message += "\n" + stripped_opponent + " does not exist"
      end
    end
  end
end
