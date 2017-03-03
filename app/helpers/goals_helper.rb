module GoalsHelper
  def calc_percent(user, goal)
    (user.races.where(goal_id: goal.id).first.progress / goal.total_distance * 100).round(2).to_s.concat(" %")
  end
  def convert_meters_to_miles(meters, digits)
    (meters * 0.000621371).round(digits)
  end
end
