class Race < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates_uniqueness_of :goal_id, :scope => :user_id
end
