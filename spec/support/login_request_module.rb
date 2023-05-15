module SignInRequestModule
  def sign_in_request_as(external_coach)
    session_params = { external_coach_login_form: { email: external_coach.email, password: external_coach.password } }
    post "/external_coach/session", params: session_params
  end
end