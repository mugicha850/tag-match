class ClubAdvisor::Base < ApplicationController
  private def current_club_advisor
    if session[:club_advisor_id]
      @current_club_advisor ||=
        ClubAdvisor.find_by(id: session[:club_advisor_id])
    end
  end
  
  # before_actionコールバックとして使うためlogin_requiredを作成
  private def login_required
    raise LoginRequired unless current_club_advisor
  end  
  helper_method :current_club_advisor
end