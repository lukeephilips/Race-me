require 'rails_helper'

describe "the add a new goal" do
  before do
    @user = FactoryGirl.create(:user)
  end
  it "views current goals", js: true do
    visit '/'
    click_on 'Sign In'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    click_on 'Goals'
    click_on 'Add a Goal'
    fill_in 'goal[name]', :with => 'oregon thing'
    fill_in 'goal[start_location]', :with => 'Portland, or'
    fill_in 'goal[end_location]', :with => 'Eugene, or'
    click_on 'Create Goal'

    expect(page).to have_content "You saved oregon thing"
  end
end
