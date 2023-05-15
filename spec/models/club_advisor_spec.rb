require 'rails_helper'

RSpec.describe ClubAdvisor, type: :model do
  it 'is valid with valid attributes' do
    club_advisor = build(:club_advisor)
    expect(club_advisor).to be_valid
  end

  it 'is not valid without an email' do
    club_advisor = build(:club_advisor, email: nil)
    expect(club_advisor).to_not be_valid
  end

  it 'is not valid with an invalid email' do
    club_advisor = build(:club_advisor, email: 'invalid_email')
    expect(club_advisor).to_not be_valid
  end

  let(:email) { 'example@example.com' }

  before { create(:club_advisor, email: email) } # 既に同じemailを持つユーザーを作成しておく

  it 'it is not valid with same email' do
    user = build(:club_advisor, email: email)
    expect(user).to_not be_valid
  end  

  it 'is not valid without a family_name' do
    club_advisor = build(:club_advisor, family_name: nil)
    expect(club_advisor).to_not be_valid
  end

  it 'is not valid without a given_name' do
    club_advisor = build(:club_advisor, given_name: nil)
    expect(club_advisor).to_not be_valid
  end

  it 'is not valid without a start_date' do
    club_advisor = build(:club_advisor, start_date: nil)
    expect(club_advisor).to_not be_valid
  end

  it 'is not valid without a birthday' do
    club_advisor = build(:club_advisor, birthday: Date.today)
    expect(club_advisor).to_not be_valid
  end

  it 'is not valid without a sex' do
    club_advisor = build(:club_advisor, sex: nil)
    expect(club_advisor).to_not be_valid
  end
end
