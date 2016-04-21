class AddPointsToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :points, :integer, null: false, default: 1
  end
end
