FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "User ##{i}" }
    github_id 123_456
  end

  factory :project do
    sequence(:name) { |i| "Project ##{i}" }
  end
end
