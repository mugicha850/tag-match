class Alter2Articles < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :ec_articles, :external_coaches  # 外部キー制約
  end
end
