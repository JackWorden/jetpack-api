class AddGithubAccessTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_access_token, :string
    add_index :users, :github_access_token, unique: true
  end
end
