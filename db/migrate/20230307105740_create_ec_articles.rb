class CreateEcArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :ec_articles do |t|
      t.string :title, null: false          # タイトル
      t.text :body_1, null: false             # 本文1
      t.text :body_2, null: false             # 本文2
      t.text :body_3, null: false             # 本文3
      t.datetime :released_at, null: false  # 掲載開始日時
      t.datetime :expired_at                # 掲載終了日時
      t.boolean :external_coach_only, null: false, default: false     # 会員のみフラグ

      t.timestamps
    end
  end
end