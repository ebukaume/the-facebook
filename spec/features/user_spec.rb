# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users' do
  let(:returning_user) { FactoryBot.create(:user) }
  let(:malicious_user) { FactoryBot.create(:user) }

  def new_user
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      sex: %w[Male Female Custom].sample,
      dob: 18.years.ago
    }
  end

  def login(user)
    within 'form.form-inline' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log In'
    end
  end

  def create_post(content)
    fill_in 'post[content]', with: content
    click_button 'Post'
  end

  scenario 'can create account' do
    visit root_path

    within '.new_user' do
      fill_in 'user[first_name]', with: new_user[:first_name]
      fill_in 'user[last_name]', with: new_user[:last_name]
      fill_in 'user[email]', with: new_user[:email]
      fill_in 'user[password]', with: new_user[:password]
      select new_user[:dob].day, from: 'user[dob(3i)]'
      select Date::MONTHNAMES[new_user[:dob].month], from: 'user[dob(2i)]'
      select new_user[:dob].year, from: 'user[dob(1i)]'
      choose new_user[:sex]
      click_button 'Sign Up'
    end

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'can login' do
    visit root_path

    login(returning_user)

    expect(page).to have_content(returning_user.first_name)
  end

  scenario 'can log out' do
    visit root_path

    login(returning_user)
    click_link 'Log Out'

    expect(page).not_to have_content(returning_user.first_name)
  end

  scenario 'can create post' do
    visit root_path

    login(returning_user)
    post_content = Faker::Lorem.paragraph
    create_post(post_content)

    expect(page).to have_content(post_content)
  end

  scenario 'can edit his post' do
    visit root_path

    login(returning_user)
    post_content = Faker::Lorem.paragraph
    create_post(post_content)
    click_link 'Edit'
    new_content = Faker::Lorem.paragraph
    fill_in 'post[content]', with: new_content
    click_button 'Save Edit'

    expect(page).not_to have_content(post_content)
  end

  scenario 'can delete his post' do
    visit root_path

    login(returning_user)
    post_content = Faker::Lorem.paragraph
    create_post(post_content)
    click_link 'Delete'

    expect(page).not_to have_content(post_content)
  end
end