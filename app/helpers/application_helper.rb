module ApplicationHelper
  def convert_meters_to_miles(meters, digits)
    (meters * 0.000621371).round(digits)
  end
  def display_date(date)
    date.month.to_s + "/" + date.day.to_s + "/" + date.year.to_s
  end

  def convert_seconds(seconds, new_time)
    if new_time == "minutes"
      seconds / 60
    elsif new_time "hours"
      seconds /360
    end
  end
end
