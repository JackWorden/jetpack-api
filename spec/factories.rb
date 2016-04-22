FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "Team ##{i}" }
  end

  factory :user do
    sequence(:name) { |i| "User ##{i}" }
    github_id 123_456
  end

  factory :project do
    sequence(:name) { |i| "Project ##{i}" }
  end

  factory :sprint do
    end_date { Time.zone.today + rand(1..30).days }
    project
  end

  factory :story do
    sequence(:title) { |i| "Story ##{i}" }
    project
  end

  factory :issue do
    sequence(:description) { |i| "Issue ##{i}" }
    project
  end

  factory :comment do
    body 'This is a comment...'
    issue
    user
  end
end
