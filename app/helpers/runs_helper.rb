module RunsHelper
  def convert_meters_to_miles(meters, digits)
    (meters * 0.000621371).round(digits)
  end
  def convert_seconds(seconds, new_time)
    if new_time == "minutes"
      seconds / 60
    elsif new_time "hours"
      seconds /360
    end
  end
end
