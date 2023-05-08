require 'rails_helper'

RSpec.describe "EcArticles", type: :system do
  let!(:ca_article) { create(:ca_article)}
  before do
    driven_by(:rack_test)
    visit '/external_coach/articles'
  end

  describe '#index' do
    it 'renders the articles page' do
      expect(page.status_code).to eq(200)
    end

    it 'displays content of the article' do
      expect(page).to have_content ca_article.title
    end

    it 'displays a link to the details screen' do
      expect(page).to have_link 'Show this article', href: "/external_coach/articles/#{article.id}"
    end

    it 'displays a link to post a article' do
      expect(page).to have_link 'New article', href: "/external_coach/articles/accounts"
    end

    it 'renders the articles page' do
      visit '/club_advisor/articles'
      expect(page.status_code).to eq(200)
    end
  end
end
