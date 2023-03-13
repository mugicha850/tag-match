class ExternalCoach::ArticlesController < ExternalCoach::Base
  
  before_action :redirect_if_data_present, only: [:new]

  # 記事一覧
  def index
    @articles = EcArticle.order(released_at: :desc)
    #@articles = @articles.open_to_the_public unless current_member
    #@articles = @articles.page(params[:page]).per(5)
    unless current_external_coach
        @articles = @articles.visible
    end
  end

  # 記事詳細
  def show
    #@articles = EcArticle.visible
    #@articles = @articles.open_to_the_public unless current_member
    @article = EcArticle.find(params[:id])
    #@article = @articles.find(params[:id])
  end

  # 新規登録フォーム
  def new
    @article = EcArticle.new
  end

  # 編集フォーム
  def edit
    @article = EcArticle.find(params[:id])
  end

  # 新規作成
  def create
    @article = EcArticle.new(ec_article_params)
    if @article.save
      redirect_to :external_coach_articles, notice: "ニュース記事を登録しました。"
    else
      render "new"
    end
  end

  # 更新
  def update
    @article = EcArticle.find(params[:id])
    @article.assign_attributes(ec_article_params)
    if @article.save
      redirect_to external_coach_article_path(@article), notice: "ニュース記事を更新しました。"
    else
      render "edit"
    end
  end

  # 削除
  def destroy
    @article = EcArticle.find(params[:id])
    @article.destroy
    redirect_to :external_coach_articles
  end

  private def ec_article_params
    params.require(:ec_article).permit(
        :title,
        :body_1,
        :body_2,
        :body_3,
        :released_at,
        :expired_at,
        :no_expiration,
        :external_coach_only
    )
  end

  private def redirect_if_data_present
    if EcArticle.exists?
        redirect_to :external_coach_articles
    end
  end
end
