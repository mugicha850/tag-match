class Alter1Articles < ActiveRecord::Migration[6.1]
  def change
    add_reference :ec_articles, :external_coach, null: false  # 外部キー
    add_column :ec_articles, :status, :string, null: false, default: "draft" # 状態
  end
end
