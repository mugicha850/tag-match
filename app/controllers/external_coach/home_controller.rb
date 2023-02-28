class ExternalCoach::HomeController < ExternalCoach::Base
  def index
    render action: "index"
  end

  def test
    render action: "test"
  end

  def test2
    @test = test
  end
end
