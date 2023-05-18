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
  end
end
