RSpec.shared_context "external_coach_setup" do
  let!(:external_coach) { create(:external_coach, email: 'user@example.com', password: 'password', family_name: '田中', given_name: '太郎', family_name_kana: 'タナカ', given_name_kana: 'タロウ', start_date: Date.today, end_date: nil, suspended: false, sport_id: 1, area_id: 1, created_at: '2022-08-04', birthday: '1992-09-02', sex: 1) }
end