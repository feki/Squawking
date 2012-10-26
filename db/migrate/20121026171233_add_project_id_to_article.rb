class AddProjectIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :project_id, :integer
  end
end
