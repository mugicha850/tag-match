module SignInModule
  def sign_in_as(club_advisor)
    visit '/club_advisor/login'
    fill_in 'club_advisor_login_form_email', with: club_advisor.email
    fill_in 'club_advisor_login_form_password', with: 'password'
    click_button 'ログインする'
  end
end