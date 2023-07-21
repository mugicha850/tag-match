class ExternalCoach::ArticlesController < ExternalCoach::Base
  
  #クラブアドバイザー:記事一覧
  def index
      @articles = CaArticle.common
      .visible.order(released_at: :desc)
      .page(params[:page]).per(5)
  end

  # クラブアドバイザー:記事詳細
  def show
    @article = CaArticle.find(params[:id])
    @club_advisor = @article.author
    @external_coach = current_external_coach

    Rails.logger.debug "Club Advisor: #{@club_advisor.inspect}"
    Rails.logger.debug "External Coach: #{current_external_coach.inspect}"

    # ここでis_followed_by?メソッドの結果をログに出力
    is_followed = @club_advisor.is_followed_by?(current_external_coach)
    Rails.logger.debug "Is Club Advisor followed by External Coach?: #{is_followed}"
  end
end
