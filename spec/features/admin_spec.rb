require 'rails_helper'

feature "Users login and logout" do
  background do
    @user = User.create!(login: 'sevos', password: 'qwerty',
                         password_confirmation: 'qwerty',
                         role: 'admin')
  end

  scenario "Admin signs in", js: true do
    visit '/'

    within '#login_form' do
      fill_in 'Login', with: 'sevos'
      fill_in 'Password', with: 'qwerty'
      click_button 'Sign in'
    end
    wait_for_ajax

    within '#navigation' do
      expect(page).to have_content('Manage users')
    end

  end
end
