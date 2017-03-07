module GoalsHelper
  def calc_percent(user, goal)
    (user.races.where(goal_id: goal.id).first.progress / goal.total_distance * 100).round(2).to_s.concat("%")
  end
  def progress_color(percent)
    percent = percent.to_i
    if percent < 11
      "very-low"
    elsif percent < 26
            "low"
    elsif percent < 51
            "medium"
    elsif percent < 76
            "high"
    elsif percent < 90
            "very-high"
    end
  end
end
