class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :runs
  has_many :goals, :through => :races
  has_many :races
  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessor :client, :athlete, :activities

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if auth.info.email
        user.email = auth.info.email
      else
        user.email = rand.to_s[2..11].concat("@fake.com")
      end
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end

  # def client
  #   @client = Strava::Api::V3::Client.new(:ACCESS_TOKEN => ENV['ACCESS_TOKEN'])
  #   byebug
  # end
  # def athlete
  #   @athlete ||= self.client.retrieve_current_athlete
  # end
  # def activities
  #   @activities ||= self.client.list_athlete_activities
  # end

  # after_initialize do
  #   if self.runs.empty?
  #     self.activities.first(10).each do |activity|
  #       self.runs.create(start_latlng: activity['start_latlng'], end_latlng: activity['end_latlng'], total_distance: activity['distance'], total_time: activity['elapsed_time'], travel_method: activity['type'], strava_id: activity['id'])
  #       puts "RUNS CREATED"
  #     end
  #   end
  # end
end
