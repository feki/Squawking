class AddArticleIdToReaction < ActiveRecord::Migration
  def change
    add_column :reactions, :article_id, :integer
  end
end
