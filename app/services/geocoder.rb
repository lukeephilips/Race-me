class Geocoder
  def self.get_geo (user_place)
    response = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{user_place}&key=#{ENV['GOOGLE_MAPS_API_KEY']}"){|response, request, result| response }
    geoplace = JSON.parse(response)
    lat_lng = [
      geoplace['results'][0]['geometry']['location']['lat'],
      geoplace['results'][0]['geometry']['location']['lng']
    ]
  end

  def self.get_distance (start_loc, end_loc)
    start_location = start_loc.join(",")
    end_location = end_loc.join(",")

    resp = RestClient.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{start_location}&destinations=#{end_location}&key=#{ENV['GOOGLE_MAPS_API_KEY']}"){|response, request, result| response }

    geodistance = JSON.parse(resp)
  end
end
