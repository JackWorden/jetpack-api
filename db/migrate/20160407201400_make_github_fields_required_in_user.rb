class MakeGithubFieldsRequiredInUser < ActiveRecord::Migration
  def change
    change_column_null :users, :name, false
    change_column_null :users, :github_user_id, false
  end
end
