class AddProjectIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :project_id, :integer
  end
end
