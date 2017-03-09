class Goal < ApplicationRecord
  has_many :users, :through => :races
  has_many :races
  has_many :runs

  validates_presence_of :name
  validates_presence_of :start_location
  validates_presence_of :end_location

end
