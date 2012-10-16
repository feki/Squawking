class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
