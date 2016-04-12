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
    project
  end

  factory :story do
    sequence(:title) { |i| "Story ##{i}" }
    project
  end
end
