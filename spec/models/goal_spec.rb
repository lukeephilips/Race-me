require 'rails_helper'

describe Goal do
  it {should have_many :runs}
  it {should have_many :races}
  it {should have_many(:users).through(:races)}

  it {should validate_presence_of :name}
  it {should validate_uniqueness_of :name}
end
