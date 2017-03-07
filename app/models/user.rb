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

  attr_accessor :client, :athlete, :activities

  def client
    @client
    # @client = Strava::Api::V3::Client.new(:access_token => ENV['ACCESS_TOKEN'])

    # access_information = Strava::Api::V3::Auth.retrieve_access(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], 'code')
  end
  def athlete
    @athlete
    # @athlete ||= self.client.retrieve_current_athlete
  end
  def activities
    @activities
    # @activities ||= self.client.list_athlete_activities
  end

  # after_initialize do
  #   if user_signed_in? && self.runs.empty?
  #     self.activities.first(10).each do |activity|
  #       self.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'])
  #       puts "RUNS CREATED"
  #     end
  #   end
  # end
end
