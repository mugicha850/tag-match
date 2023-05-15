require 'rails_helper'

RSpec.describe "ExternalCoach::Sessions", type: :system do
  let!(:external_coach) { create(:external_coach, email: 'user@example.com', password: 'password', family_name: '田中', given_name: '太郎', family_name_kana: 'タナカ', given_name_kana: 'タロウ', start_date: Date.today, end_date: nil, suspended: false, sport_id: 1, area_id: 1, created_at: Date.today, sex: 1) }
  before do
    driven_by(:rack_test)
  end

  describe 'Screen Session' do
    before do
      visit '/external_coach/login'
    end

    describe '#new' do
      it 'displays a form for email' do
        expect(page).to have_field 'external_coach_login_form[email]'
      end

      it 'displays a form for password' do
        expect(page).to have_field 'external_coach_login_form[password]'
      end

      it 'displays a create login button' do
        expect(page).to have_button 'ログインする'
      end

      it 'displays a link to back to list screen' do
        expect(page).to have_link '戻る', href: "/external_coach/articles"
      end
    end

    describe '#created' do
      context 'login' do
        it 'success_logined' do
          fill_in 'external_coach_login_form_email', with: external_coach.email
          fill_in 'external_coach_login_form_password', with: 'password'
          click_button 'ログインする'
  
          # ログインが成功したことを確認
          expect(page).to have_content 'ログインしました。'
        end
      end
      context 'fatal login' do
        it 'not_logined' do
          fill_in 'external_coach_login_form_email', with: external_coach.email
          fill_in 'external_coach_login_form_password', with: ''
          click_button 'ログインする'
  
          # ログインが失敗したことを確認
          expect(page).to have_content 'メールアドレスまたはパスワードが正しくありません。'
        end
      end
    end
    
  end

end
