require 'rails_helper'

RSpec.describe "ExternalCoach::Accounts", type: :system do
  context 'If you are logged_in.' do
    include_context "user_setup"
    before do
      sign_in_as(external_coach)
    end

    describe 'Screen' do
      before do
        visit '/external_coach/account'
      end
      
      describe '#show' do
        it 'renders the account page' do
          expect(page.status_code).to eq(200)
        end
      end
    end
  end

  context 'If you did not log_in.' do
    let!(:ec_article) { create(:ec_article) }
    before do
      driven_by(:rack_test)
    end
    describe 'Screen' do
      before do
        visit '/external_coach/account'
      end
      
      describe '#show' do
        it 'renders the account page' do
          expect(page.status_code).not_to eq(200)
        end
      end
    end
  end
end
