require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let!(:ca_article) { create(:ca_article, title: 'タイトル', body_2: 'テスト2', body_1: 'テスト3', body_1: 'テスト3', released_at: Date.today, status: 'public') }
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
      save_and_open_page
    end

    it 'displays login of the article' do
      expect(page).to have_content ('ログイン')
    end

    it 'displays follow of the article' do
      expect(page).to have_content ('フォロー')
    end

    it 'displays see-later of the article' do
      expect(page).to have_content ('あとで見る')
    end

    it 'displays profile of the article' do
      expect(page).to have_content ('プロフィール')
    end

    it 'displays account of the article' do
      expect(page).to have_content ('アカウント')
    end

    it 'displays TAG Match of the article' do
      expect(page).to have_content ('TAG Match')
    end

    it 'displays a link to the details screen' do
      expect(page).to have_link 'タイトル', href: "/external_coach/articles/#{ca_article.id}"
    end

    it 'renders the articles page' do
      visit '/club_advisor/articles'
      expect(page.status_code).to eq(200)
    end
  end
end