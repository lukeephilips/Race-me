require 'rails_helper'

describe "the add a new run" do
  it "views current runs" do
    @user = FactoryGirl.create(:user)
    goal = @user.goals.create(
      name: 'moon',
      start_location: 'here',
      end_location: 'there',
      total_distance: 1609.34
    )
    visit '/'
    click_on 'Sign In'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    click_on 'Runs'
    click_on 'Add a Run'
    fill_in 'run[total_distance]', :with => '1609.34'
    fill_in 'run[total_time]', :with => '3600'
    fill_in 'run[date]', :with => '12/01/2017'
    select goal.name, from: 'run[goal_id]'
    click_on 'Create Run'
    
    expect(page).to have_content "60.0 minutes per mile"
  end
end
