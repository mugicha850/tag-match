class Alter1CaArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :ca_articles, :club_advisor, null: false  # 外部キー
  end
end
