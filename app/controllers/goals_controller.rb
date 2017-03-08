class GoalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:search_term]
      @goals = Goal.basic_search(params[:search_term])
      respond_to do |format|
        format.js
      end
    else
      @goals = Goal.all
      respond_to do |format|
        format.js
        format.html {render :index}
      end
    end
  end

  def show
    @goal = Goal.find(params[:id])
    @user = current_user
    @user_origin = @goal['start_location']
    @user_destination = @goal['end_location']
  end

  def new
    @user = current_user
    @goal = Goal.new
  end

  def create
    user_name = goal_params[:name]
    user_start_location = goal_params[:start_location]
    user_end_location = goal_params[:end_location]
    user_start_latlng = Geocoder.get_geo(user_start_location)
    user_end_latlng = Geocoder.get_geo(user_end_location)
    user_total_distance = Geocoder.get_distance(user_start_latlng, user_end_latlng)['rows'][0]['elements'][0]['distance']['value']

    @user = current_user
    @goal = Goal.new({name: user_name, start_location: user_start_location, end_location: user_end_location, start_latlng: user_start_latlng, end_latlng: user_end_latlng, total_distance: user_total_distance})
    @goals = Goal.all.collect{|goal| [goal.name, goal.id]}
    if @goal.save

      @user.races.create(goal_id: @goal.id, progress: 0)

      flash_message = "You saved #{@goal.name}"
      if params[:opponents] != ''
        opponents = params[:opponents].split(", ")
        opponents.each do |invited_opponent|
          stripped_opponent = invited_opponent.strip
          if User.exists?(email: stripped_opponent)
            invited_user = User.find_by(email: stripped_opponent)
            invited_user.races.create(user_id: invited_user.id, goal_id: @goal.id, progress: 0)
            flash_message += "\n"+"and invited " + invited_user.email
          else
            flash_message += "\n" + stripped_opponent + " does not exist"
          end
        end

        flash[:notice] = flash_message
        respond_to do |format|
          format.js
          format.html {redirect_to user_goal_path(current_user,@goal)}
        end
      end
    else
      flash[:alert] = @goal.errors.full_messages.each {|m| m.to_s}.join
      render :new
    end
  end

  def edit
    @user = current_user
    @goal = Goal.find(params[:id])
    @goals = @user.goals.collect{|goal| [goal.name, goal.id]}

  end

  def update
    @user = current_user
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
    @user = current_user
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "You deleted #{@goal.name}"
    redirect_to user_goals_path(current_user)
  end

  private

  def goal_params
    if params[:search_term]
    else
      params.require(:goal).permit(:start_location, :end_location, :name, :total_distance)
    end
  end
end
