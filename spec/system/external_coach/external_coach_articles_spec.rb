require 'rails_helper'

RSpec.describe "ExternalCoach::Articles", type: :system do
  let!(:ca_article) { create(:ca_article, title: 'タイトル', body_1: 'テスト1', body_2: 'テスト2', body_3: 'テスト3', released_at: Date.today, status: 'public') }
  
  describe 'List Screen' do
    before do
      driven_by(:rack_test)
      visit '/external_coach/articles'
    end

    describe '#index' do
      it 'renders the ca_articles page' do
        expect(page.status_code).to eq(200)
      end
      
      # 入力したカラムが表示されるか
      it 'displays title of the ca_article' do
        expect(page).to have_content ca_article.title
      end
  
      it 'displays body_1 of the ca_article' do
        expect(page).to have_content ca_article.body_1
      end
  
      # コンテントの表示がされているか
      it 'displays login of the ca_article' do
        expect(page).to have_content ('ログイン')
      end
  
      it 'displays follow of the ca_article' do
        expect(page).to have_content ('フォロー')
      end
  
      it 'displays see-later of the ca_article' do
        expect(page).to have_content ('あとで見る')
      end
  
      it 'displays profile of the ca_article' do
        expect(page).to have_content ('プロフィール')
      end
  
      it 'displays account of the ca_article' do
        expect(page).to have_content ('アカウント')
      end
  
      it 'displays TAG Match of the ca_article' do
        expect(page).to have_content ('TAG Match')
      end
  
      # リンクが設定されているか
      it 'displays a link to the title screen' do
        expect(page).to have_link 'タイトル', href: "/external_coach/articles/#{ca_article.id}"
      end
  
      it '【Not Yet Create!】displays a link to the follow screen' do
        expect(page).to_not have_link 'フォロー', href: "/external_coach/articles/follow"
      end
  
      it '【Not Yet Create!】displays a link to the see-later screen' do
        expect(page).to_not have_link 'あとで見る', href: "/external_coach/articles/see_later"
      end
  
      it 'displays a link to the profile screen' do
        expect(page).to have_link 'プロフィール', href: "/external_coach/profile"
      end
  
      it 'displays a link to the account screen' do
        expect(page).to have_link 'アカウント', href: "/external_coach/account"
      end
  
      it 'displays a link to the login screen' do
        expect(page).to have_link 'ログイン', href: "/external_coach/login"
      end
  
      it 'renders the ca_articles page' do
        visit '/club_advisor/articles'
        expect(page.status_code).to eq(200)
      end
    end
  end


  describe '#Detail Screen' do
    before do
      visit external_coach_article_path(ca_article)
    end

    describe '#show' do
      # 入力したカラムが表示されるか
      it 'displays title of the ca_article' do
        expect(page).to have_content ca_article.title
      end
  
      it 'displays body_1 of the ca_article' do
        expect(page).to have_content ca_article.body_1
      end

      it 'displays body_2 of the ca_article' do
        expect(page).to have_content ca_article.body_2
      end

      it 'displays body_3 of the ca_article' do
        expect(page).to have_content ca_article.body_3
      end
      
      # リンクが表示されているか
      it 'displays a link to back to list screen' do
        expect(page).to have_link '戻る', href: "/external_coach/articles"
      end
    end
  end

end