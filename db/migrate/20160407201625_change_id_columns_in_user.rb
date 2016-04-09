class ChangeIdColumnsInUser < ActiveRecord::Migration
  def change
    remove_column :users, :uid
    rename_column :users, :github_user_id, :github_id
  end
end
