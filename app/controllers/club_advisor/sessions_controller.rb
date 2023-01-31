class ClubAdvisor::SessionsController < ClubAdvisor::Base
    def new
    if current_club_advisor
      redirect_to :club_advisor_root
    else
      @form = ClubAdvisor::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = ClubAdvisor::LoginForm.new(params[:club_advisor_login_form])
    if @form.email.present?
      club_advisor =
        ClubAdvisor.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if ClubAdvisor::Authenticator.new(club_advisor).authenticate(@form.password)
      if club_advisor.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:club_advisor_id] = club_advisor.id
        flash.notice = "ログインしました。"
        redirect_to :club_advisor_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    session.delete(:club_advisor_id)
    flash.notice = "ログアウトしました。"
    redirect_to :club_advisor_root
  end
end
