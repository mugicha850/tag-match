class ClubAdvisor::ArticlesController < ClubAdvisor::Base
  
  # 外部コーチ:記事一覧
  def index
    @articles = EcArticle.common
    .visible.order(released_at: :desc)
    .page(params[:page]).per(5)
  end

  # 外部コーチ:記事詳細
  def show
    @article = EcArticle.find(params[:id])
    @external_coach = @article.author
    @club_advisor = current_club_advisor

    Rails.logger.debug "Club Advisor: #{@external_coach.inspect}"
    Rails.logger.debug "External Coach: #{current_club_advisor.inspect}"

    # ここでis_followed_by?メソッドの結果をログに出力
    is_followed = @external_coach.is_followed_by?(current_club_advisor)
    Rails.logger.debug "Is Club Advisor followed by External Coach?: #{is_followed}"
  end
end
