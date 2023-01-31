class CreateClubAdvisors < ActiveRecord::Migration[6.1]
  def change
    create_table :club_advisors do |t|

      t.string :email, null: false                      # メールアドレス
      t.string :family_name, null: false                # 姓
      t.string :given_name, null: false                 # 名
      t.string :family_name_kana, null: false           # 姓（カナ）
      t.string :given_name_kana, null: false            # 名（カナ）
      t.string :career                                  # 名（カナ）
      t.string :hashed_password                         # パスワード
      t.date :start_date, null: false                   # 開始日
      t.date :end_date                                  # 終了日
      t.boolean :suspended, null: false, default: false # 無効フラグ

      t.references :sport                               # 外部キー
      t.references :area                                # 外部キー
      t.references :school                              # 外部キー
      t.references :club                                # 外部キー

      t.timestamps
    end
    # add_index :club_advisor, "LOWER(email)", unique: true
    # add_index :club_advisor, [ :family_name_kana, :given_name_kana ]
    
  end
end
