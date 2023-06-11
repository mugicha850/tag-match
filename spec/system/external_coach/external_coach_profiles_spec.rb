require 'rails_helper'

RSpec.describe "ExternalCoach::Profiles", type: :system do
  context 'If you are logged_in.' do
    include_context "external_coach_setup"

    before do
      sign_in_as(external_coach)
    end
    describe 'Screen' do
      before do
        visit '/external_coach/profile'
        puts current_url
      end
      
      describe '#show' do
        it 'renders the profile page' do
          expect(page.status_code).to eq(200)
        end

        it "displays a link to the profile-new page" do
          expect(page).to have_link('公開プロフィールを作成する', href: '/external_coach/profile/new')
        end
        it "displays a content of the 記事がまだありません。" do
          expect(page).to have_content('記事がまだありません。')
        end
      end
    end

    describe 'Screen' do
      before do
        visit '/external_coach/profile/new'
        puts current_url
      end
      
      describe '#new' do
        it 'created a ec_article, and does the data exist?' do
          fill_in 'ec_article_title', with: 'aaa'
          fill_in 'ec_article_body_1', with: 'bbb'
          fill_in 'ec_article_body_2', with: 'ccc'
          fill_in 'ec_article_body_3', with: 'ddd'
          select '2023', from: 'ec_article_released_at_1i'  # Year
          select '1', from: 'ec_article_released_at_2i'  # Month
          select '1', from: 'ec_article_released_at_3i'  # Day
          select '公開', from: 'ec_article_status'
          click_button '作成する'
          expect(page).to have_content('会員の詳細')
          expect(page).to have_content('aaa')
          expect(page).to have_content('bbb')
          expect(page).to have_content('ccc')
          expect(page).to have_content('ddd')
          expect(page).to have_content('2023/01/01')

          # データベースに保存されているか確認
          ec_article = EcArticle.find_by(external_coach_id: external_coach.id)
          expect(ec_article).not_to be_nil
          expect(ec_article.title).to eq('aaa')
          expect(ec_article.body_1).to eq('bbb')
          expect(ec_article.body_2).to eq('ccc')
          expect(ec_article.body_3).to eq('ddd')

          # EcArticleにデータが存在している場合、newページに遷移できないか確認
          visit new_external_coach_profile_path
          puts current_url
          expect(current_path).to eq(external_coach_articles_path)
          puts current_url
        end
      end
    end
  end
end
