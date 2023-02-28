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
    @external_coach.assign_attributes(params[:external_coach])
    if @external_coach.save
      redirect_to :external_coach_account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

end
