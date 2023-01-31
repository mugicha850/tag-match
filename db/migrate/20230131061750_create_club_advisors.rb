class CreateClubAdvisors < ActiveRecord::Migration[6.1]
  def change
    create_table :club_advisors do |t|

      t.timestamps
    end
  end
end
