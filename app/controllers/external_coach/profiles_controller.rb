class ExternalCoach::ProfilesController < ExternalCoach::Base
  
  # ログイン前にアクセスするとエラーページに遷移
  before_action :login_required

  def show
    @external_coach = current_external_coach
    @article = @external_coach.ec_article
  end

  # 外部コーチ:編集フォーム
  def edit
    @external_coach = current_external_coach
    @article = @external_coach.ec_article
  end

  # 外部コーチ:新規登録フォーム
  def new
    if EcArticle.exists?(external_coach_id: current_external_coach)
      redirect_to :external_coach_articles
    else
      @article = EcArticle.new
    end
  end

  # 外部コーチ:新規作成
  def create
    @article = EcArticle.new(ec_article_params)
    @article.author = current_external_coach
    if @article.save
      redirect_to :external_coach_profile, notice: "ニュース記事を登録しました。"
    else
      render "new"
    end
  end

  # 外部コーチ:更新
  def update
    @external_coach = current_external_coach
    @article = @external_coach.ec_article
    @article.assign_attributes(ec_article_params)
    if @article.save
      redirect_to external_coach_profile_path(@article), notice: "ニュース記事を更新しました。"
    else
      render "edit"
    end
  end

  # 外部コーチ:削除
  def destroy
    @external_coach = current_external_coach
    @article = @external_coach.ec_article
    @article.destroy
    redirect_to :external_coach_profile
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
        :external_coach_only,
        :external_coach_id,
        :status
    )
  end
  
  private def redirect_if_data_present
    if current_external_coach.ec_article.present?
        redirect_to :external_coach_articles
    end
  end
end
