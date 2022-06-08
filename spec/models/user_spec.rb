require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'Random photo', bio: 'Random bio', PostsCounter: 2) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'PostsCounter should be present' do
    subject.PostsCounter = nil
    expect(subject).to_not be_valid
  end

  it 'PostsCounter should be greater than or equal to 0' do
    subject.PostsCounter = -1
    expect(subject).to_not be_valid
  end
end
