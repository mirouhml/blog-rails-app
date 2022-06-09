require 'rails_helper'

describe Comment, type: :model do
  subject {
    user = User.create(name: 'John', photo: 'Random photo', bio: 'Random bio', PostsCounter: 0)
    post = Post.create(title: 'title', text: 'eRandom text', CommentsCounter: 0, LikesCounter: 0, author_id: user.id) 
    Comment.new(author_id: user.id, post_id: post.id, text: 'Random text')
  }

  before { subject.save }

  it 'Text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'Author should be present' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'Post should be present' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'update_comments_counter should set the counter to 3' do
    subject.update_comments_counter(3)
    expect(subject.post.CommentsCounter).to eq 3
  end
end