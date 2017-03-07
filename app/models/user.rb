class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :runs
  has_many :goals, :through => :races
  has_many :races
  validates_presence_of :name
  validates_uniqueness_of :name

  # attr_accessor :client, :athlete, :activities

  # def client
  #   @client
  #   # @client = Strava::Api::V3::Client.new(:access_token => ENV['ACCESS_TOKEN'])
  #
  #   # access_information = Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], 'code')
  # end
  # def athlete
  #   @athlete
  #   # @athlete ||= self.client.retrieve_current_athlete
  # end
  # def activities
  #   @activities
  #   # @activities ||= self.client.list_athlete_activities
  # end

  def after_database_authentication
    puts "DB call to populate runs"
    if self.token
      @client = Strava::Api::V3::Client.new(:access_token => self.token)
      @athlete ||= @client.retrieve_current_athlete
      @activities ||= @client.list_athlete_activities
      @users = User.all

      if self.runs.empty?
        @activities.first(20).each do |activity|
          self.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'], date: Time.parse(activity['start_date_local']))
          puts "RUNS CREATED"
        end
      else
        # up_to_date = false
        # while up_to_date == false
          @activities.first(20).each do |activity|
            if !self.runs.where(strava_id: activity['id']).exists?
              self.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'], date: Time.parse(activity['start_date_local']))
              puts "RUN #{activity['id']} CREATED"
            end
          # end
        end
      end
    end
  end
end
