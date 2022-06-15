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
    post = Post.all.second
    click_link(post.title)
  end

  it 'can see the post\'s title' do
    user = User.all.first
    expect(page).to have_content(user.posts.second.title)
  end

  it 'can see who worte the post' do
    user = User.all.first
    expect(page).to have_content(user.name)
  end

  it 'can see how many comments the post has' do
    post = Post.all.second
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  it 'can see how many likes a post have' do
    post = Post.all.second
    expect(page).to have_content("Likes: #{post.LikesCounter}")
  end

  it 'can see the post body' do
    post = Post.all.second
    expect(page).to have_content(post.text)
  end

  it 'See the username of each commentor' do
    post = Post.all.second
    post.comments.includes(:user).each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'See the comment of each commentor' do
    post = Post.all.second
    post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
