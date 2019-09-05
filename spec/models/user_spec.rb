# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:new_user) { FactoryBot.build(:user) }

  it 'is a valid user' do
    expect(new_user).to be_valid
  end

  it 'is invalid when user has incorrect email format' do
    new_user.email = 'a' * 7
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user does not provide first name' do
    new_user.first_name = nil
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user has too short first name' do
    new_user.first_name = 'a'
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user has too long first name' do
    new_user.first_name = 'a' * 51
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user does not provide last name' do
    new_user.last_name = nil
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user has too short last name' do
    new_user.last_name = 'a'
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user has too long last name' do
    new_user.last_name = 'a' * 51
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user does not provide sex' do
    new_user.sex = nil
    expect(new_user).not_to be_valid
  end

  it 'is invalid when user provides wrong sex category' do
    new_user.sex = 'aaa'
    expect(new_user).not_to be_valid
  end
end
