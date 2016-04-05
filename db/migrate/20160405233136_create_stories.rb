class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :project, null: false
      t.references :sprint
    end
  end
end
