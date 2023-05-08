require 'rails_helper'

RSpec.describe CaArticle, type: :model do
  
  let(:ca_article) { build(:ca_article) }
  it "is valid with a valid ca_article" do
    expect(ca_article).to be_valid
  end

  # ---- titleのテストコード ----
  it "is not valid without a title" do
    ca_article.title = ''
    expect(ca_article).to_not be_valid
  end
  it "is not valid with a title longer than 80" do
    ca_article.title = Faker::Lorem.characters(number: 81)
    expect(ca_article).to_not be_valid
  end

  # ---- body_1のテストコード ----
  it "is not valid without a body_1" do
    ca_article.body_1 = ''
    expect(ca_article).to_not be_valid
  end
  it "is not valid with a body_1 longer than 2000" do
    ca_article.body_1 = Faker::Lorem.characters(number: 2001)
    expect(ca_article).to_not be_valid
  end


  # ---- body_2のテストコード ----
  it "is not valid without a body_2" do
    ca_article.body_2 = ''
    expect(ca_article).to_not be_valid
  end
  it "is not valid with a body_2 longer than 2000" do
    ca_article.body_2 = Faker::Lorem.characters(number: 2001)
    expect(ca_article).to_not be_valid
  end

  # ---- body_3のテストコード ----
  it "is not valid without a body_3" do
    ca_article.body_3 = ''
    expect(ca_article).to_not be_valid
  end
  it "is not valid with a body_3 longer than 2000" do
    ca_article.body_3 = Faker::Lorem.characters(number: 2001)
    expect(ca_article).to_not be_valid
  end

  # ---- released_atのテストコード ----
  # it "is not valid without a released_at" do
  #   ca_article.released_at = ''
  #   expect(ca_article).to_not be_valid
  # end
  it "is not valid with a released_at longer than 100 years" do 
    ca_article.released_at = DateTime.now + 100.years
    expect(ca_article).to_not be_valid
  end

  # ---- expired_atのテストコード ----
  it "is not valid without a expired_at" do
    ca_article.expired_at = ''
    expect(ca_article).to be_valid
  end
  it "is not valid with a expired_at longer than 100 years" do 
    ca_article.expired_at = DateTime.now + 100.years
    expect(ca_article).to be_valid
  end

  # ---- club_advisor_idのテストコード ----
  it "is not valid without a club_advisor_id" do
    ca_article.club_advisor_id = ''
    expect(ca_article).to_not be_valid
  end

  # ---- stausのテストコード ----
  it "is not valid without a status" do
    ca_article.status = '' 
    expect(ca_article).to_not be_valid
  end  
end