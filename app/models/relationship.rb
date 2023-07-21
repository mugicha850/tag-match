class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "ClubAdvisor"
  belongs_to :following, class_name: "ExternalCoach"
end