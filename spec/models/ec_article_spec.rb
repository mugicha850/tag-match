require 'rails_helper'

RSpec.describe EcArticle, type: :model do
  
  let(:ec_article) { build(:ec_article) }
  it "is valid with a valid ec_article" do
    expect(ec_article).to be_valid
  end

  # ---- titleのテストコード ----
  it "is not valid without a title" do
    ec_article.title = ''
    expect(ec_article).to_not be_valid
  end
  it "is not valid with a title longer than 80" do
    ec_article.title = Faker::Lorem.characters(number: 81)
    expect(ec_article).to_not be_valid
  end

  # ---- body_1のテストコード ----
  it "is not valid without a body_1" do
    ec_article.body_1 = ''
    expect(ec_article).to_not be_valid
  end
  it "is not valid with a body_1 longer than 2000" do
    ec_article.body_1 = Faker::Lorem.characters(number: 2001)
    expect(ec_article).to_not be_valid
  end


  # ---- body_2のテストコード ----
  it "is not valid without a body_2" do
    ec_article.body_2 = ''
    expect(ec_article).to_not be_valid
  end
  it "is not valid with a body_2 longer than 2000" do
    ec_article.body_2 = Faker::Lorem.characters(number: 2001)
    expect(ec_article).to_not be_valid
  end

  # ---- body_3のテストコード ----
  it "is not valid without a body_3" do
    ec_article.body_3 = ''
    expect(ec_article).to_not be_valid
  end
  it "is not valid with a body_3 longer than 2000" do
    ec_article.body_3 = Faker::Lorem.characters(number: 2001)
    expect(ec_article).to_not be_valid
  end

  # ---- released_atのテストコード ----
  # it "is not valid without a released_at" do
  #   ec_article.released_at = ''
  #   expect(ec_article).to_not be_valid
  # end
  it "is not valid with a released_at longer than 100 years" do 
    ec_article.released_at = DateTime.now + 100.years
    expect(ec_article).to_not be_valid
  end

  # ---- expired_atのテストコード ----
  it "is not valid without a expired_at" do
    ec_article.expired_at = ''
    expect(ec_article).to be_valid
  end
  it "is not valid with a expired_at longer than 100 years" do 
    ec_article.expired_at = DateTime.now + 100.years
    expect(ec_article).to be_valid
  end

  # ---- external_coach_idのテストコード ----
  it "is not valid without a external_coach_id" do
    ec_article.external_coach_id = ''
    expect(ec_article).to_not be_valid
  end

  # ---- stausのテストコード ----
  it "is not valid without a status" do
    ec_article.status = '' 
    expect(ec_article).to_not be_valid
  end  
end