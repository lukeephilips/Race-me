require 'rails_helper'

describe Race do
  it {should belong_to :goal}
  it {should belong_to :user}

end
