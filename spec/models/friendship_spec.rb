# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship do
  it { belong_to(:user) }
  it { belong_to(:friend) }
end
