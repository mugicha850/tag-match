require 'rails_helper'

RSpec.describe "ExternalCoach::Sessions", type: :request do
  let!(:external_coach) { create(:external_coach, email: 'user@example.com', password: 'password', family_name: '田中', given_name: '太郎', family_name_kana: 'タナカ', given_name_kana: 'タロウ', start_date: Date.today, end_date: nil, suspended: false, sport_id: 1, area_id: 1, created_at: '2022-08-04', birthday: '1992-09-02', sex: 1) }
  describe "GET /external_coach/sessions" do
    it "displays of the new login page" do
      get external_coach_login_path
      expect(response).to have_http_status(200)
      puts external_coach.inspect
    end
  end

  describe "POST /external_coach/sessions" do
    it 'displays of the created a session' do
      post external_coach_session_path, params: { external_coach_login_form: { email: 'user@example.com', password: 'password' } }
      expect(session[:external_coach_id]).not_to be_nil
    # もしくは以下のコードでログインをテストできる。
    # expect(logged_in?).to be_truthy
      puts session.inspect
    end
  end

  describe "DELETE /external_coach/sessions" do
    it 'displays of the destroy a session' do
      post external_coach_session_path, params: { external_coach_login_form: { email: 'user@example.com', password: 'password' } }
    # もしくは以下のコードでログインをテストできる。
    # expect(logged_in?).to be_truthy
      delete external_coach_session_path
      expect(session[:external_coach_id]).to be_nil
      puts session.inspect
    end
  end
end