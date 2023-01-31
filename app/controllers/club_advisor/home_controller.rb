class ClubAdvisor::HomeController < ClubAdvisor::Base
  def index
    render action: "index"
  end
end
