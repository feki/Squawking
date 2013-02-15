class CreateProjectsUsersJoin < ActiveRecord::Migration
  def change
  	create_table :projects_users, :id => false do |t|
	  t.references :project, :user
	end

	add_index :projects_users, [:project_id, :user_id]
  end
end