class ExternalCoach::RelationshipsController < ExternalCoach::Base
  before_action :login_required
  def create
    following = current_external_coach.active_relationships.build(follower_id: params[:club_advisor_id])
    following.save
    redirect_to request.referrer || root_path
  end

  def destroy
    following = current_external_coach.active_relationships.find_by(follower_id: params[:club_advisor_id])
    following.destroy
    redirect_to request.referrer || root_path
  end
end
