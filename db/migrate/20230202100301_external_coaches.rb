class ExternalCoaches < ActiveRecord::Migration[6.1]
  def change
    add_column :external_coaches, :birthday, :date                              # 生年月日
    add_column :external_coaches, :sex, :integer, null: false, default: 1       # 性別(1:男, 2:女)
  end
end
