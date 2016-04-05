class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :project, null: false
      t.references :sprint
      t.references :story
      t.references :user
    end
  end
end
