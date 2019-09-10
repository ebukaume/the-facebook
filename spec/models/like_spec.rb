# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryBot.build(:like) }

  it "is invalid when like doesn't reference a liker" do
    like_without_liker = FactoryBot.build(:like, liker_id: nil)
    expect(like_without_liker).not_to be_valid
  end

  it "is invalid when like doesn't reference neither a comment nor a post" do
    like_without_liker = FactoryBot.build(:like, likeable: nil)
    expect(like_without_liker).not_to be_valid
  end

  describe '#liker' do
    it 'returns the owner of the like' do
      expect(like.liker).to be_an_instance_of User
    end
  end
end
