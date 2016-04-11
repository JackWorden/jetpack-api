class AddsActiveSprintIdToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.references :active_sprint
    end
  end
end
