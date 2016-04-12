class AddTitleToStory < ActiveRecord::Migration
  def change
    add_column :stories, :title, :string, null: false
  end
end
