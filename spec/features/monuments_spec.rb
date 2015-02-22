# coding: utf-8
require 'rails_helper'

feature "monuments", js: true do
  include CarrierWaveDirect::Test::CapybaraHelpers
  include UsersHelper

  background do
    @user = User.create!(login: 'sevos', password: 'qwerty',
                         password_confirmation: 'qwerty')
    login 'sevos', 'qwerty'

    within('#navigation') do
      click_link 'My collections'
    end

    within('#new-collection') do
      fill_in 'Title', with: 'Winter 2015'
      click_button 'Create'
      wait_for_ajax
    end
  end

  scenario "User creates new monument" do
    within('.collection', text: 'Winter 2015') do
      click_link 'New monument'
    end

    fill_in 'Name', with: 'Siegessaeule'
    fill_in 'Description', with: <<-TEXT
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc a pharetra mauris. Ut vitae eros maximus mi condimentum volutpat. Donec accumsan ex nunc, nec ultricies justo efficitur eget. Sed vulputate elit id augue auctor luctus. Quisque vehicula velit a tristique tincidunt. Praesent hendrerit, libero quis euismod placerat, dolor neque pellentesque nibh, euismod iaculis mi nisi nec lectus. Quisque sem dolor, blandit et augue at, pellentesque ultrices diam. Etiam vehicula leo sit amet ligula hendrerit, eu facilisis eros suscipit. Pellentesque hendrerit hendrerit diam nec iaculis. Mauris tincidunt iaculis dolor, quis placerat dolor rutrum at. Suspendisse posuere odio dictum libero porttitor dignissim. Vivamus rhoncus dolor aliquet euismod convallis. Donec facilisis mauris vel elit aliquam viverra. Nulla faucibus in turpis condimentum hendrerit.

Vivamus cursus nulla tellus. Aliquam ultrices dignissim neque vel accumsan. Sed volutpat porttitor sodales. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque posuere nibh nec enim scelerisque, at porta ligula volutpat. Proin auctor tincidunt consequat. Nunc sed augue id lacus mollis porta quis at turpis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque est tellus, luctus eget mollis eget, rutrum at justo. Morbi at urna vestibulum, placerat tortor in, aliquam est. Nam vulputate turpis nulla. Morbi a tempor ante.
    TEXT

    click_button 'Continue'

    page.driver.block_unknown_urls
    attach_file_for_direct_upload(Rails.root.join('spec', 'fixtures', 'example.jpg'))
    upload_directly(PhotoUploader.new, "Create Photo upload")

    click_button 'Continue'

    expect(page).to have_content('Siegessaeule')
    expect(page).to have_content('Lorem ipsum dolor')

    click_button 'Continue'

    within('.collection') do
      expect(page).to have_content('Winter 2015')
      expect(page).to have_content('Siegessaeule')
    end
  end
end
