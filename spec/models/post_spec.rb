require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { 
    user = User.create(name: 'John', photo: 'Random photo', bio: 'Random bio', PostsCounter: 0)
    post = Post.new(title: 'title', text: 'Random text', CommentsCounter: 0, LikesCounter: 0, author_id: user.id) 
  }

  before { subject.save }

  it 'Title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'CommentsCounter should be present' do
    subject.CommentsCounter = nil
    expect(subject).to_not be_valid
  end

  it 'CommentsCounter should be greater than or equal to 0' do
    subject.CommentsCounter = -1
    expect(subject).to_not be_valid
  end

  it 'LikesCounter should be present' do
    subject.LikesCounter = nil
    expect(subject).to_not be_valid
  end

  it 'LikesCounter should be greater than or equal to 0' do
    subject.LikesCounter = -1
    expect(subject).to_not be_valid
  end

  it 'recent_comments should return an empty array' do
    expect(subject.recent_comments).to be
  end

  it 'update_posts_counter should set the counter to 2' do
    subject.update_posts_counter(2)
    expect(subject.author.PostsCounter).to eq 2
  end
end