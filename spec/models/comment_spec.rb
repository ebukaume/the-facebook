# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  let(:comment) { FactoryBot.build(:comment) }

  it { is_expected.to validate_presence_of(:content) }
  it { belong_to(:user) }
  it { belong_to(:post) }
  it { have_many(:likes) }

  it 'is valid post when comment reference both an author and a post' do
    expect(comment).to be_valid
  end

  it "is valid post when comment doesn't reference a post" do
    comment_without_post = FactoryBot.build(:comment, post_id: nil)
    expect(comment_without_post).not_to be_valid
  end

  it "is valid post when comment doesn't reference an author" do
    comment_without_author = FactoryBot.build(:comment, post_id: nil)
    expect(comment_without_author).not_to be_valid
  end

  describe '#author' do
    it 'returns the author of the comment' do
      expect(comment.author).to be_an_instance_of User
    end
  end

  describe '#post' do
    it 'returns the post that has the comment' do
      expect(comment.post).to be_an_instance_of Post
    end
  end
end
