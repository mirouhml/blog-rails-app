require 'rails_helper'

RSpec.describe 'user_index', type: :feature do
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'lilly@gmail.com'
    fill_in 'Password', with: 'lilly12345'
    click_button 'Log in'
  end

  it 'See the username of all other users ' do
    expect(page).to have_content('Tom')
    expect(page).to have_content('Lilly')
  end

  it 'See the profile picture of each user' do
    expect(page.html).to include('user-image')
  end

  it 'See the number of post of each user' do
    user = User.all.first
    expect(page).to have_content("Number of posts: #{user.PostsCounter}")
  end

  it 'should redirect to user show page when click on a user' do
    user = User.all.first
    click_link(user.name)
    expect(page.current_path).to eql(user_path(id: user.id))
  end
end
