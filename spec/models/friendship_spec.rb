# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship do
  it { belong_to(:user) }
  it { belong_to(:friend) }

  let(:alice) { FactoryBot.create(:user) }
  let(:bob) { FactoryBot.create(:user) }

  it 'should establish friendship between 2 users' do
    f = alice.friendships.build(friend: bob)

    expect(f).to be_valid
  end

  it 'should validate irrflexiveness of friendship' do
    f = alice.friendships.build(friend: alice)

    expect(f).not_to be_valid
  end

  it 'should prevent duplicate friendship entries' do
    alice.friendships.create(friend: bob)
    f = alice.friendships.build(friend: bob)

    expect(f).not_to be_valid
  end
end
