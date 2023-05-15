module LoginSupport
  def logged_in?
    !session[:external_coach_id].nil?
  end
end
 
RSpec.configure do |config|
  config.include LoginSupport
end