class DataSeeder
  def initialize(team, user)
    @team = team
    @user = user
  end

  def seed
    create_seed_data
  end

  protected

  attr_reader :team, :user

  private

  def create_seed_data
    2.times do
      Project.create(name: "Sample Project ##{i}").tap do |project|
        create_sprints_for(project)
        create_stories_for(project, project_id: project.id)
        create_issues_for(project, project_id: project.id)
      end
    end
  end

  def create_sprints_for(project)
    project.sprints.create(end_date: 3.weeks.from_now)
    project.update(
      active_sprint: project.sprints.create(start_date: Date.today, end_date: 1.week.from_now)
    )

    project.sprints.each do |sprint|
      create_stories_for(sprint, project_id: project.id)
      create_issues_for(sprint, project_id: project.id)
    end
  end

  def create_stories_for(obj, project_id:)
    rand(2..3).times do
      story = obj.stories.create(title: "Sample Story ##{Story.count}", project_id: project_id)
      create_issues_for(story, project_id: project_id)
    end
  end

  def create_issues_for(obj, project_id:)
    rand(2..5).times do
      issue = obj.issues.create(
        description: "Sample Issue ##{Issue.count}",
        points: rand(1..5),
        status: Issue.statuses.values.sample,
        assignee: [nil, user].sample,
        project_id: project_id
      )
      create_comments_for(issue)
    end
  end

  def create_comments_for(issue)
    rand(2..5).times do
      issue.comments.create(body: "Sample Comment ##{Comment.count}", user: user)
    end
  end
end
