class CaArticle < ApplicationRecord
  belongs_to :author, class_name: "ClubAdvisor", foreign_key: "club_advisor_id"  

  STATUS_VALUES = %w(draft public)

  validates :title, :body_1, :body_2, :body_3, :released_at, presence: true
  validates :title, length: { maximum: 80 }
  validates :body_1, :body_2, :body_3, length: { maximum: 2000 }
  validates :status, inclusion: { in: STATUS_VALUES }

  # commonスコープは公開記事を選び出します
  scope :common, -> { where(status: "public") }
  
  # publishedスコープは下書き状態ではない記事、つまり公開記事と会員限定記事を選び出します
  #scope :published, -> { where("status <> ?", "draft") }
  
  # fullスコープでは
  scope :full, ->(club_advisor) {
    where("club_advisor_id = ? OR status <> ?", club_advisor.id, "draft") }
  scope :readable_for, ->(club_advisor) { club_advisor ? full(club_advisor) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.ec_article.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end


  def no_expiration
    expired_at.nil?
  end

  # このコードは、Rubyのクラスにおけるインスタンス変数@no_expirationのセッターメソッドを定義しています。
  # メソッド名はno_expiration=で、=（イコール）がメソッド名に含まれることで、Rubyでは自動的にセッターメソッドとして扱われます。
  # 引数valが与えられると、in?メソッドを使って、valが[true, "1"]のいずれかに含まれている場合はtrue、そうでない場合はfalseを返します。そして、その結果を@no_expirationに代入しています。
  # つまり、このメソッドは、trueまたは"1"が引数として渡された場合は@no_expirationにtrueを、それ以外の場合はfalseをセットするために使用されます。
  def no_expiration=(val)
    @no_expiration = val.in?([true, "1"])
  end

  # 「掲載終了日時を設定しない」がオンの場合、(no_expiration属性がtrueの場合)は、expired_at属性をnilにしましょう
  before_validation do 
    self.expired_at = nil if @no_expiration
  end

  # 掲載開始日時から掲載終了日時の間を取得する
  scope :visible, -> do
    now = Time.current
    
    where("released_at <= ?", now)
      .where("expired_at > ? OR expired_at IS NULL", now)
  end

  # 掲載終了日時が掲載開始日時よりも前の時点であればエラー
  validate do 
    if expired_at && expired_at < released_at
        errors.add(:expired_at, :expired_at_too_old)
    end
  end
end
