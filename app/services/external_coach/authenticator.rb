class ExternalCoach::Authenticator
  def initialize(external_coach)
    @external_coach = external_coach
  end

  def authenticate(raw_password)
    @external_coach &&
      !@external_coach.suspended? &&
      @external_coach.hashed_password &&
      @external_coach.start_date <= Date.today &&
      (@external_coach.end_date.nil? || @external_coach.end_date > Date.today) &&
      BCrypt::Password.new(@external_coach.hashed_password) == raw_password
  end
end