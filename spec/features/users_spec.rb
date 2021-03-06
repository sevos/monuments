require 'rails_helper'

feature "Users login and logout" do
  background do
    @user = User.create!(login: 'sevos', password: 'qwerty',
                         password_confirmation: 'qwerty')
  end

  scenario "User signs in", js: true do
    visit '/'

    within '#login_form' do
      fill_in 'Login', with: 'sevos'
      fill_in 'Password', with: 'qwerty'
      click_button 'Sign in'
    end
    wait_for_ajax

    within '#user_info' do
      expect(page).to have_content(@user.login)
    end

    # Normal user is not an admin
    within '#navigation' do
      expect(page).not_to have_content('Manage users')
    end

    within '#logout_form' do
      click_link 'Logout'
    end

    expect(page).to have_css('#login_form')
  end
end
