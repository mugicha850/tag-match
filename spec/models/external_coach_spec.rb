require 'rails_helper'

RSpec.describe ExternalCoach, type: :model do
  it 'is valid with valid attributes' do
    external_coach = build(:external_coach)
    expect(external_coach).to be_valid
  end

  it 'is not valid without an email' do
    external_coach = build(:external_coach, email: nil)
    expect(external_coach).to_not be_valid
  end

  it 'is not valid with an invalid email' do
    external_coach = build(:external_coach, email: 'invalid_email')
    expect(external_coach).to_not be_valid
  end

  let(:email) { 'example@example.com' }

  before { create(:external_coach, email: email) } # 既に同じemailを持つユーザーを作成しておく

  it 'it is not valid with same email' do
    user = build(:external_coach, email: email)
    expect(user).to_not be_valid
  end  
  
  it 'is not valid without a family_name' do
    external_coach = build(:external_coach, family_name: nil)
    expect(external_coach).to_not be_valid
  end

  it 'is not valid without a given_name' do
    external_coach = build(:external_coach, given_name: nil)
    expect(external_coach).to_not be_valid
  end

  it 'is not valid without a start_date' do
    external_coach = build(:external_coach, start_date: nil)
    expect(external_coach).to_not be_valid
  end

  it 'is not valid without a birthday' do
    external_coach = build(:external_coach, birthday: Date.today)
    expect(external_coach).to_not be_valid
  end

  it 'is not valid without a sex' do
    external_coach = build(:external_coach, sex: nil)
    expect(external_coach).to_not be_valid
  end
end
