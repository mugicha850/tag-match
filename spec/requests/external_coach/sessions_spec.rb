require 'rails_helper'

RSpec.describe "ExternalCoach::Sessions", type: :request do
  let!(:external_coach) { create(:external_coach, email: 'user@example.com', password: 'password') }
  describe "GET /external_coach/sessions" do
    it "displays of the new login page" do
      get external_coach_login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /external_coach/sessions" do
    it 'displays of the created session' do
      post external_coach_session_path, params: login_form_params
      expect(logged_in?).to be_truthy
    end
  end

  private def login_form_params
    params.require(:external_coach_login_form).permit(:email, :password)
  end
end
