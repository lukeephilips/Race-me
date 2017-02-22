require 'rails_helper'

describe User do
  it { should have_many :runs }
  it { should have_many(:goals).through(:races) }
  it { should have_many :races }

  it {should validate_presence_of :name}
  it {should validate_uniqueness_of :name}

end
