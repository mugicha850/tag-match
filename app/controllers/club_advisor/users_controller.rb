class ClubAdvisor::UsersController < ClubAdvisor::Base
  def index
    @club_advisor = ClubAdvisor.order(:family_name_kana, :given_name_kana)
    # ページネーション
    .page(params[:page]).per(15)
    render json: @club_advisor
  end

  def show
    @club_advisor = ClubAdvisor.find(params[:id])
    redirect_to [ :edit, :admin, club_advisor ]
  end

  def new
    if current_club_advisor
      redirect_to :club_advisor_root
    else
      @club_advisor = ClubAdvisor.new
      render action: "new"
    end
  end

  def edit
    @club_advisor = ClubAdvisor.find(params[:id])
  end

  def update
    @club_advisor = ClubAdvisor.find(params[:id])
    @club_advisor.assign_attributes(params[:club_advisor])
    if @club_advisor.save
      flash.notice = "職員アカウントを更新しました。"
      redirect_to :club_advisor_users
    else
      render action: "edit"
    end
  end
 
  def create
    @club_advisor = ClubAdvisor.new(club_advisor_params)
    if @club_advisor.save
      flash.notice = "職員アカウントを新規登録しました。"
      render json: @club_advisor, status: :created
      #redirect_to :club_advisor_users



    else
      render action: "new"
    end
  end

  def destroy
    club_advisor = ClubAdvisor.find(params[:id])
    club_advisor.destroy!
    flash.notice = "職員アカウントを削除しました。"
    redirect_to :club_advisor_root
  end

  private def new_form_params
    params.require(:club_advisor).permit(:email, :password)
  end

  private def club_advisor_params
    params.permit(
        :email,
        :password,
        :family_name,
        :given_name,
        :family_name_kana,
        :given_name_kana,
        :career,
        :start_date,
        :end_date,
        :suspended,
        :sport_id,
        :area_id,
        :school_id,
        :club_id,
        :created_at,
        :updated_at,
        :birthday,
        :sex
    )
  end
end
