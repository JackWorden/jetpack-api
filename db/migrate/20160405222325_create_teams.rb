class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.column :name, :string, null: false
      t.timestamps null: false
    end
  end
end
