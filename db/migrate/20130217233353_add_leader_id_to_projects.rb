class AddLeaderIdToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :leader_id, :integer
  end
end
