class ProjectSerializer < ApplicationSerializer
  attributes :id, :name
  has_many :sprints
  has_many :stories
  has_many :issues

  link(:self) { project_path(object) }
  link(:related) do
    {
      sprints: project_sprints_path(object),
      stories: project_stories_path(object),
      issues: project_issues_path(object)
    }
  end
end
