module GoalsHelper
  def calc_percent(user, goal)
    (user.races.where(goal_id: goal.id).first.progress / goal.total_distance * 100).round(2).to_s.concat(" %")
  end
end
