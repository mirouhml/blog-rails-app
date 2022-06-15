require 'rails_helper'

RSpec.describe 'user_show', type: :feature do
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'lilly@gmail.com'
    fill_in 'Password', with: 'lilly12345'
    click_button 'Log in'
    user = User.all.first
    click_link(user.name)
  end

  it 'can see the user\'s profile picture' do
    expect(page.html).to include('user-image')
  end

  it 'can see the user\'s username' do
    user = User.all.first
    expect(page).to have_content(user.name)
  end

  it 'can see the user\'s number of posts' do
    user = User.all.first
    expect(page).to have_content("Number of posts: #{user.PostsCounter}")
  end

  it 'can see the user\'s bio' do
    user = User.all.first
    expect(page).to have_content(user.bio)
  end

  it 'can see the user\'s first 3 posts' do
    expect(page).to have_selector('.post-link', count: 3)
  end

  it 'can see a button that lets the user see all posts' do
    expect(page).to have_link('See all posts')
  end

  it 'redirects to the post\'s page when a post is clicked' do
    user = User.all.first
    post = Post.all.second
    click_link(post.title)
    expect(page.current_path).to eql(user_post_path(user_id: user.id, id: post.id))
  end

  it 'redirects to the user\'s posts page when the button See all posts is clicked' do
    user = User.all.first
    click_link('See all posts')
    expect(page.current_path).to eql("#{user_posts_path(user_id: user.id)}/")
  end
end
