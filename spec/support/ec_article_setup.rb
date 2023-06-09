RSpec.shared_context "ec_article_setup" do
  let!(:ec_article) { create(:ec_article, title: 'タイトル', body_1: 'テスト1', body_2: 'テスト2', body_3: 'テスト3', released_at: Date.today, status: 'public') }
end