class ClubAdvisor < ApplicationRecord
  has_one :ca_article, dependent: :destroy 

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  # current_passwordの書き込み・読み取りを可能にする
  attr_accessor :current_password

  # バリデーションの設定
  HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}A-Za-z]+\z/
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :email, presence: true, "valid_email_2/email": true,
    uniqueness: { case_sensitive: false }
  validates :family_name, :given_name, presence: true,
    format: { with: HUMAN_NAME_REGEXP, allow_blank: true }
  validates :family_name_kana, :given_name_kana, presence: true,
    format: { with: KATAKANA_REGEXP, allow_blank: true }
  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  # パスワード変更時のバリデーション, このバリデーションは、「password」という属性（カラム）に対して、存在性（presence）のバリデーションを行うことを意味しています。「if: :current_password」というオプションは、「current_password」というメソッドが「true」を返す場合のみバリデーションが実行されます。
  validates :password, presence: {if: :current_password}

  validate :above_18_years_old

  def above_18_years_old
    if birthday.present? && birthday >= 18.years.ago.to_date
      errors.add(:birthday, "must be above 18 years old")
    end
  end

  validates :sex, presence: true
end
