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
  end
end
