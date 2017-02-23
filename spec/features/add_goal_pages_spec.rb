require 'rails_helper'

describe "the add a new run" do
  it "views current runs", js: true do
    user = FactoryGirl.create(:user)
    goal = FactoryGirl.create(:goal)
    visit '/'
    click_on 'Log In'
    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    click_on 'View Runs'
    click_on 'Add a Run'
    click_link 'Add a Goal'
    fill_in 'Name', :with => 'A new goal'

    find_button('Create Goal').click
    expect(Goal.find_by(name: "A new goal"))
    # expect(page).to_not have_content "buddy"
  end
end
