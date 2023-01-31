class ClubAdvisor::Authenticator
  def initialize(club_advisor)
    @club_advisor = club_advisor
  end

  def authenticate(raw_password)
    @club_advisor &&
      !@club_advisor.suspended? &&
      @club_advisor.hashed_password &&
      @club_advisor.start_date <= Date.today &&
      (@club_advisor.end_date.nil? || @club_advisor.end_date > Date.today) &&
      BCrypt::Password.new(@club_advisor.hashed_password) == raw_password
  end
end