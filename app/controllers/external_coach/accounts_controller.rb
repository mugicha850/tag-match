class ExternalCoach::AccountsController < ExternalCoach::Base

  # ログイン前にアクセスするとエラーページに遷移
  before_action :login_required

  def show
    @external_coach = current_external_coach
  end

  def edit
    @external_coach = current_external_coach
  end
  
  def update
    @external_coach = current_external_coach
    @external_coach.assign_attributes(ec_account_params)
    if @external_coach.save
      redirect_to :external_coach_account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  private def ec_account_params
    params.require(:external_coach).permit(
        :email,
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
        :created_at,
        :updated_at,
        :birthday,
        :sex
    )
  end
end
