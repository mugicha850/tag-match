class ClubAdvisor::ProfilesController < ClubAdvisor::Base
  # ログイン前にアクセスするとエラーページに遷移
  before_action :login_required
  
  def show
    @club_advisor = current_club_advisor
    @article = @club_advisor.ca_article
  end

  # クラブアドバイザー:編集フォーム
  def edit
    @club_advisor = current_club_advisor
    @article = @club_advisor.ca_article
  end

  # クラブアドバイザー:新規登録フォーム
  def new
    if CaArticle.exists?(club_advisor_id: current_club_advisor)
      redirect_to :club_advisor_articles
    else
      @article = CaArticle.new
    end
  end


  # クラブアドバイザー:新規作成
  def create
    @article = CaArticle.new(ca_article_params)
    @article.author = current_club_advisor
    if @article.save
      redirect_to :club_advisor_articles, notice: "ニュース記事を登録しました。"
    else
      render "new"
    end
  end

  # クラブアドバイザー:更新
  def update
    @club_advisor = current_club_advisor
    @article = @club_advisor.ca_article
    @article.assign_attributes(ca_article_params)
    if @article.save
      redirect_to club_advisor_profile_path(@article), notice: "ニュース記事を更新しました。"
    else
      render "edit"
    end
  end

  # クラブアドバイザー:削除
  def destroy
    @article = CaArticle.find(params[:id])
    @article.destroy
    redirect_to :club_advisor_articles
  end

  private def ca_article_params
    params.require(:ca_article).permit(
        :title,
        :body_1,
        :body_2,
        :body_3,
        :released_at,
        :expired_at,
        :no_expiration,
        :club_advisor_only,
        :club_advisor_id,
        :status
    )
  end

  private def redirect_if_data_present
    if current_club_advisor.ca_article.present?
        redirect_to :club_advisor_articles
    end
  end
end
