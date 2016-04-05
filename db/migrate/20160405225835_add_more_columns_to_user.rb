class AddMoreColumnsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :team_id, index: true
    add_column :users, :uid, :integer
    add_column :users, :name, :string
  end
end
