class AddGithubInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_access_token, :string
    add_column :users, :github_user_id, :integer
  end
end
