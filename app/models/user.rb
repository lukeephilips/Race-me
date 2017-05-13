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

  def after_database_authentication
    check_for_token_and_runs
  end

  def check_for_token_and_runs
    if token
      @client = Strava::Api::V3::Client.new(:access_token => token)
      @athlete ||= @client.retrieve_current_athlete
      @activities ||= @client.list_athlete_activities.first(20)
    end

    if token && runs.empty?
      @activities.each{|activity| create_run(activity) }
    elsif token && runs.any?
      @activities.each do |activity|
        if runs.where(strava_id: activity['id']).none?
          create_run(activity)
        end
      end
    end
  end

  def create_run(activity)
    runs.create(
      start_latlng: activity['start_latlng'],
      end_latlng: activity['end_latlng'],
      total_distance: activity['distance'],
      total_time: activity['elapsed_time'],
      travel_method: activity['type'],
      strava_id: activity['id'],
      date: Time.parse(activity['start_date_local'])
    )
  end
  def walkthrough
    if !token?
      "Welcome! First things first, login to your strava account in the navbar"
    elsif runs.empty?
      "Looks like you don't have any new runs on strava. Go to Runs in the navbar to manually enter one"
    elsif runs.any? && races.empty?
      "Next up, create a Goal"
    elsif runs.any?
      "Assign your new runs to an active goal to move along your virtual route"
    end
  end
end
