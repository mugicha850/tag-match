class ApplicationController < ActionController::Base
  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  private def set_layout
    if params[:controller].match(%r{\A(external_coach|club_advisor)/})
      Regexp.last_match[1]
    else
      "club_advisor"
    end
  end
end