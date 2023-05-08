require 'rails_helper'

RSpec.describe "ExternalCoach::Accounts", type: :system do
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
        expext(page.status_code).to eq(200)
      end
    end
  end
end
