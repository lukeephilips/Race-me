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

  attr_accessor :client, :thing

  # after_initialize do
    def client
      @client = Strava::Api::V3::Client.new(:access_token => ENV['ACCESS_TOKEN'])
    end
  # end
end
