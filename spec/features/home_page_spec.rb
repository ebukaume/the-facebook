require 'rails_helper'

RSpec.describe 'homepage;' do
  scenario 'user sees home banner' do
    visit(root_path)
    expect(page).to have_content "facebook"
  end

  scenario 'user sees sign up form' do
    visit(root_path)
    expect(page).to have_content "Create a new account"
  end

  scenario 'user sees log in form' do
    visit(root_path)
    expect(page).to have_button "Log in"
  end
end
