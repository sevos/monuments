require 'rails_helper'

feature "Collections" do
  include UsersHelper

  def create_collection(name)
    within('#navigation') do
      click_link 'My collections'
    end

    within('#new-collection') do
      fill_in 'Title', with: name
      click_button 'Create'
      wait_for_ajax
    end
  end

  background do
    @user = User.create!(login: 'sevos', password: 'qwerty',
                         password_confirmation: 'qwerty')
  end

  scenario "User creates new collection", js: true do
    login 'sevos', 'qwerty'
    create_collection 'Winter 2015'
    expect(page).to have_css('h1', text: 'Winter 2015')
  end

  scenario "User removes a collection", js: true do
    login 'sevos', 'qwerty'

    create_collection 'Winter'

    within(".collection", text: 'Winter') do
      page.driver.browser.accept_js_confirms
      click_link 'Delete'
    end

    expect(page).not_to have_content('Winter')

    within('#navigation') do
      click_link 'My collections'
    end

    expect(page).not_to have_content('Winter')
  end

  scenario "User does not see collections of another user", js: true do
    another_user = User.create!(login: 'someone', password: 'qwerty',
                                password_confirmation: 'qwerty')
    another_collection = Collection.create!(user: another_user,
                                            title: 'Holidays 2013')

    login 'sevos', 'qwerty'

    within('#navigation') do
      click_link 'My collections'
    end

    expect(page).not_to have_content(another_collection.title)
  end
end
