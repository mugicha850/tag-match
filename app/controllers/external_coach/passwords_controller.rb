class ExternalCoach::PasswordsController < ExternalCoach::Base
  before_action :login_required

  def show
    redirect_to :edit_external_coach_password
  end

  def edit
    @change_password_form =
      ExternalCoach::ChangePasswordForm.new(object: current_external_coach)
  end

  def update
    @change_password_form = ExternalCoach::ChangePasswordForm.new(external_coach_params)
    @change_password_form.object = current_external_coach
    if @change_password_form.save
      flash.notice = "パスワードを変更しました。"
      redirect_to :external_coach_account
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "edit"
    end
  end

  private def external_coach_params
    params.require(:external_coach_change_password_form).permit(
      :current_password, :new_password, :new_password_confirmation
    )
  end

end
