class ExternalCoach::Base < ApplicationController
  private def current_external_coach
    if session[:external_coach_id]
      @current_external_coach ||=
        ExternalCoach.find_by(id: session[:external_coach_id])
    end
  end
  
  # before_actionコールバックとして使うためlogin_requiredを作成
  private def login_required
    raise LoginRequired unless current_external_coach
  end
  helper_method :current_external_coach
end