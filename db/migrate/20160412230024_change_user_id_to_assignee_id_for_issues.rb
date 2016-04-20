class ChangeUserIdToAssigneeIdForIssues < ActiveRecord::Migration
  def change
    rename_column :issues, :user_id, :assignee_id
  end
end
