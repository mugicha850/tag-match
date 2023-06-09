RSpec.shared_context "ca_article_setup" do
  let!(:ca_article) { create(:ca_article, title: 'タイトル', body_1: 'テスト1', body_2: 'テスト2', body_3: 'テスト3', released_at: Date.today, status: 'public') }
end