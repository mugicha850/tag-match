require 'rails_helper'

RSpec.describe "ExternalCoach::Profiles", type: :system do
  let!(:profile) { create(:profile)}
  before do
    driven_by(:rack_test)
    visit '/external_coach/profiles'
  end

  it 'renders the profiles page' do
    expect(page.status_code).to eq(200)
  end
end
