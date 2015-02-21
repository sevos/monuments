require 'rails_helper'

feature "Admin" do
  def login(name, password)
    visit '/'

    within '#login_form' do
      fill_in 'Login', with: name
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
    wait_for_ajax
  end

  def create_user(name, password)
    within '#navigation' do
      click_link('Manage users')
    end

    click_link "Create user"
    fill_in "Login", with: name
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_button "Create"
  end

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
