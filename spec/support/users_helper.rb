module UsersHelper
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
end
