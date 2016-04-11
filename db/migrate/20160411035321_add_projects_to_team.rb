class AddProjectsToTeam < ActiveRecord::Migration
  def change
    add_reference :teams, :projects
  end
end
