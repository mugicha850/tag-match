class ClubAdvisor::RelationshipsController < ClubAdvisor::Base
  before_action :login_required
  def create
    following = current_club_advisor.active_relationships.build(following_id: params[:external_coach_id])
    following.save
    redirect_to request.referrer || root_path
  end

  def destroy
    following = current_club_advisor.active_relationships.find_by(following_id: params[:external_coach_id])
    following.destroy
    redirect_to request.referrer || root_path
  end
end
