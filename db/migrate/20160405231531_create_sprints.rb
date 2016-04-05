class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.date :end_date
      t.references :project, null: false
    end
  end
end
