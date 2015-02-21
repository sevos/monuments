require 'rails_helper'

feature "Collections", js: true do
  include UsersHelper

  background do
    @user = User.create!(login: 'sevos', password: 'qwerty',
                         password_confirmation: 'qwerty')
  end

  scenario "User creates new collection" do
    login 'sevos', 'qwerty'

    within('#navigation') do
      click_link 'My collections'
    end

    within('#new-collection') do
      fill_in 'Title', with: 'Winter 2015'
      click_button 'Create'
      wait_for_ajax
    end

    expect(page).to have_css('h1', text: 'Winter 2015')
  end

  scenario "User removes a collection" do
    collection = Collection.create!(user_id: @user.id, title: 'Summer 2015')

    login 'sevos', 'qwerty'

    within('#navigation') do
      click_link 'My collections'
    end

    within(".collection", text: collection.title) do
      page.driver.browser.accept_js_confirms
      click_link 'Delete'
    end
  end

  scenario "User does not see collections of another user" do
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
