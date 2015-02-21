require 'rails_helper'

feature "Admin" do
  include UsersHelper

  background do
    @admin = User.create!(login: 'sevos', password: 'qwerty',
                         password_confirmation: 'qwerty',
                         role: 'admin')
  end

  scenario "Admin signs in", js: true do
    login 'sevos', 'qwerty'

    within '#navigation' do
      expect(page).to have_content('Manage users')
    end
  end

  scenario "Admin creates new user and logs in as new user", js: true do
    login 'sevos', 'qwerty'
    create_user('user', 'password')
    click_link "Logout"
    login 'user', 'password'

    within('#user_info') do
      expect(page).to have_content('user')
    end
  end

  scenario 'Admin deletes user', js: true do
    login 'sevos', 'qwerty'
    create_user('user', 'password')

    within('tr', text: 'user') do
      page.driver.browser.accept_js_confirms
      click_link 'Delete'
    end

    within('table') do
      expect(page).not_to have_content('user')
    end
  end
end
