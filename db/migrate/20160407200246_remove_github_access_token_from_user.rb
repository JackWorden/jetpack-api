class RemoveGithubAccessTokenFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :github_access_token
  end
end
