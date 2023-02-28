class ExternalCoach::ProfilesController < ExternalCoach::Base
  
  # ログイン前にアクセスするとエラーページに遷移
  before_action :login_required

  def show
    @external_coach = current_external_coach
  end

  def edit
  end
end
