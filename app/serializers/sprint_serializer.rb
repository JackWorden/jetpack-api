class SprintSerializer < ApplicationSerializer
  attributes :id, :project_id, :end_date
  has_many :stories
  has_many :issues

  link(:self) { sprint_path(object) }
  link(:stories) { sprint_stories_path(object) }
  link(:issues) { sprint_issues_path(object) }
end
