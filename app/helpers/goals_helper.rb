module GoalsHelper
  def calc_percent(user, goal)
    percent = (user.races.where(goal_id: goal.id).first.progress / goal.total_distance *
     100).round(2)
     if percent <= 100
       percent.to_s.concat("%")
     else
       "100%"
     end
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
    elsif percent < 100
      "very-high"
    else
      "chicken-dinner"
    end
  end
end
