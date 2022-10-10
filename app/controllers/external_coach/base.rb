class ExternalCoach::Base < ApplicationController
  private def current_external_coach
    if session[:external_coach_id]
      @current_external_coach ||=
        ExternalCoach.find_by(id: session[:external_coach_id])
    end
  end
  
  helper_method :current_external_coach
end