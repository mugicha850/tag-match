class ExternalCoach::UsersController < ExternalCoach::Base
  def index
    @external_coach = ExternalCoach.order(:family_name_kana, :given_name_kana)
    # ページネーション
    .page(params[:page]).per(15)
    render json: @external_coach
  end

  def show
    @external_coach = ExternalCoach.find(params[:id])
    redirect_to [ :edit, :admin, external_coach ]
  end

  def new
    if current_external_coach
      redirect_to :external_coach_root
    else
      @external_coach = ExternalCoach.new
      render action: "new"
    end
  end

  def edit
    @external_coach = ExternalCoach.find(params[:id])
  end

  def update
    @external_coach = ExternalCoach.find(params[:id])
    @external_coach.assign_attributes(params[:external_coach])
    if @external_coach.save
      flash.notice = "職員アカウントを更新しました。"
      redirect_to :external_coach_users
    else
      render action: "edit"
    end
  end
 
  def create
    @external_coach = ExternalCoach.new(external_coach_params)
    if @external_coach.save
      flash.notice = "職員アカウントを新規登録しました。"
      #redirect_to :external_coach_root

      @form = ExternalCoach::LoginForm.new(new_form_params)
      if @form.email.present?
        external_coach =
          ExternalCoach.find_by("LOWER(email) = ?", @form.email.downcase)
      end
        if ExternalCoach::Authenticator.new(external_coach).authenticate(@form.password)
          session[:external_coach_id] = external_coach.id
          flash.notice = "ログインしました。"
          redirect_to :external_coach_root
        end

    else
      render action: "new"
    end
  end

  def destroy
    external_coach = ExternalCoach.find(params[:id])
    external_coach.destroy!
    flash.notice = "職員アカウントを削除しました。"
    redirect_to :external_coach_root
  end

  private def new_form_params
    params.require(:external_coach).permit(:email, :password)
  end

  private def external_coach_params
    params.require(:external_coach).permit(
        :email,
        :password,
        :family_name,
        :given_name,
        :family_name_kana,
        :given_name_kana,
        :career,
        :start_date,
        :end_date,
        :suspended,
        :sport_id,
        :area_id,
        :club_id,
        :created_at,
        :updated_at,
        :birthday,
        :sex
    )
  end

end
