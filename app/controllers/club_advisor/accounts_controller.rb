class ClubAdvisor::AccountsController < ClubAdvisor::Base
  # ログイン前にアクセスするとエラーページに遷移
  before_action :login_required

  def show
    @club_advisor = current_club_advisor
  end

  def edit
    @club_advisor = current_club_advisor
  end
  
  def update
    @club_advisor = current_club_advisor
    @club_advisor.assign_attributes(ca_account_params)
    if @club_advisor.save
      redirect_to :club_advisor_account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  private def ca_account_params
    params.require(:club_advisor).permit(
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
        :school_id,
        :club_id,
        :created_at,
        :updated_at,
        :birthday,
        :sex
    )
  end

end
