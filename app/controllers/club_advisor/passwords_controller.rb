class ClubAdvisor::PasswordsController < ClubAdvisor::Base
  before_action :login_required

  def show
    redirect_to :edit_club_advisor_password
  end

  def edit
    @change_password_form =
      ClubAdvisor::ChangePasswordForm.new(object: current_club_advisor)
  end

  def update
    @change_password_form = ClubAdvisor::ChangePasswordForm.new(club_advisor_params)
    @change_password_form.object = current_club_advisor
    if @change_password_form.save
      flash.notice = "パスワードを変更しました。"
      redirect_to :club_advisor_account
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: "edit"
    end
  end

  private def club_advisor_params
    params.require(:club_advisor_change_password_form).permit(
      :current_password, :new_password, :new_password_confirmation
    )
  end
end
