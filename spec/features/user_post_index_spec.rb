require 'rails_helper'

RSpec.describe 'user_show', type: :feature do
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'lilly@gmail.com'
    fill_in 'Password', with: 'lilly12345'
    click_button 'Log in'
    user = User.all.first
    click_link(user.name)
    click_link('See all posts')
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

  it 'can see the post title' do
    user = User.all.first
    expect(page).to have_content(user.posts.second.title)
  end

  it 'can see the post body' do
    post = Post.all.first
    expect(page).to have_content(post.text)
  end

  it 'can see how many comments the post have' do
    post = Post.all.first
    expect(page).to have_content("Comments: #{post.CommentsCounter}")
  end

  it 'can see how many likes a post have' do
    post = Post.all.first
    expect(page).to have_content("Likes: #{post.LikesCounter}")
  end

  it 'has a button to show more posts' do
    expect(page).to have_link('Pagination')
  end

  it 'redirects to the post\'s page when a post is clicked' do
    post = Post.all.second
    click_link(post.title)
    expect(page.current_path).to eql(user_post_path(user_id: 1, id: 2))
  end
end
