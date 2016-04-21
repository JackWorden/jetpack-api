class AddStatusToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :status, :string, default: 'todo'
  end
end
