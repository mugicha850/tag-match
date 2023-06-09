require 'rails_helper'

RSpec.describe "ExternalCoach::Accounts", type: :system do
  context 'If you are logged_in.' do
    include_context "external_coach_setup"
    before do
      sign_in_as(external_coach)
    end      
    describe '#show' do
      before do
        visit '/external_coach/account'
      end
      it 'renders the account page' do
        expect(page.status_code).to eq(200)
      end

      it "displays a link to the account-edit page" do
        expect(page).to have_link('編集', href: '/external_coach/account')
      end
    end

    describe '#edit' do
      before do
        visit '/external_coach/account/edit'
        puts current_url
      end
      it 'created a ec_article' do
        fill_in 'external_coach_sport_id', with: 1
        fill_in 'external_coach_family_name', with: '山本'
        fill_in 'external_coach_given_name', with: '花子'
        select '1998', from: 'external_coach_birthday_1i'  # Year
        select '1', from: 'external_coach_birthday_2i'  # Month
        select '1', from: 'external_coach_birthday_3i'  # Day
        fill_in 'external_coach_email', with: 'yamamoto@example.com'
        click_button '更新'
        expect(page).to have_content('山本')
      end
    end
  end
  
  
  # context 'If you did not log_in.' do
  #   let!(:ec_article) { create(:ec_article) }
  #   before do
  #     driven_by(:rack_test)
  #   end
  #   describe 'Screen' do
  #     before do
  #       visit '/external_coach/account'
  #     end
      
  #     describe '#show' do
  #       it 'renders the account page' do
  #         expect(page.status_code).not_to eq(200)
  #       end
  #     end
  #   end
  end
end
