require 'rails_helper'

describe Like, type: :model do
  subject do
    user = User.create(name: 'John', photo: 'Random photo', bio: 'Random bio', PostsCounter: 0)
    post = Post.create(title: 'title', text: 'eRandom text', CommentsCounter: 0, LikesCounter: 0, author_id: user.id)
    Like.new(author_id: user.id, post_id: post.id)
  end

  before { subject.save }

  it 'Author should be present' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'Post should be present' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'update_likes_counter should update the counter to 2' do
    subject.update_likes_counter(2)
    expect(subject.post.LikesCounter).to eq 2
  end
end
