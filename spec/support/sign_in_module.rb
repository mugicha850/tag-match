module SignInModule
  def sign_in_as(external_coach)
    visit '/external_coach/login'
    fill_in 'external_coach_login_form_email', with: external_coach.email
    fill_in 'external_coach_login_form_password', with: 'password'
    click_button 'ログインする'
  end
end