class ClubAdvisor::Base < ApplicationController
  private def current_club_advisor
    if session[:club_advisor_id]
      @current_club_advisor ||=
        ClubAdvisor.find_by(id: session[:club_advisor_id])
    end
  end
  
  helper_method :current_club_advisor
end