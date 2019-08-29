require 'rails_helper'

RSpec.describe Post do
  let(:post) { FactoryBot.create(:post) }

  it 'is valid post if it has at least two character length content' do
    expect(post).to be_valid
  end

  it 'is invalid post if it does not have up to two character length content' do
    post.content = 'a'
    expect(post).not_to be_valid
  end

  describe '#author' do
    it 'returns the author of the post' do
      post.content = 'a' * rand(1000)
      expect(post.author).to be_an_instance_of User
    end
  end
end
