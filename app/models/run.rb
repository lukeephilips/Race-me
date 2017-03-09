class Run < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates_presence_of :date
  validates_uniqueness_of :total_distance
end
