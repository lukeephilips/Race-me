require 'rails_helper'

describe "the add a new run" do
  it "views current runs" do
    @user = FactoryGirl.create(:user)
    goal = FactoryGirl.create(:goal)
    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    click_on 'View Runs'
    click_on 'Add a Run'
    fill_in 'Start location', :with => 'here'
    fill_in 'End location', :with => 'there'
    fill_in 'Total distance', :with => '10'
    click_on 'Create Run'
    expect(page).to have_content "You're on your way to a new goal"

    click_on 'Add a Run'
    fill_in 'Start location', :with => 'here'
    fill_in 'End location', :with => 'there'
    fill_in 'Total distance', :with => '20'
    click_on 'Create Run'
  end
end
