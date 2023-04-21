class ExternalCoach::SessionsController < ExternalCoach::Base
  def new
    if current_external_coach
      redirect_to :external_coach_root
    else
      @form = ExternalCoach::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = ExternalCoach::LoginForm.new(login_form_params)
    if @form.email.present?
      external_coach =
        ExternalCoach.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if ExternalCoach::Authenticator.new(external_coach).authenticate(@form.password)
      if external_coach.suspended?
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:external_coach_id] = external_coach.id
        flash.notice = "ログインしました。"
        redirect_to :external_coach_users
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  private def login_form_params
    params.require(:external_coach_login_form).permit(:email, :password)
  end

  def destroy
    session.delete(:external_coach_id)
    flash.notice = "ログアウトしました。"
    redirect_to :external_coach_root
  end
end