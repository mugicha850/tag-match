class ExternalCoach < ApplicationRecord
    def password=(raw_password)
        if raw_password.kind_of?(String)
          self.hashed_password = BCrypt::Password.create(raw_password)
        elsif raw_password.nil?
          self.hashed_password = nil
        end
    end

    # バリデーションの設定

    # current_passwordの書き込み・読み取りを可能にする
    attr_accessor :current_password

    # パスワード変更時のバリデーション, このバリデーションは、「password」という属性（カラム）に対して、存在性（presence）のバリデーションを行うことを意味しています。「if: :current_password」というオプションは、「current_password」というメソッドが「true」を返す場合のみバリデーションが実行されます。
    validates :password, presence: {if: :current_password}
end
