FactoryGirl.define do
  sequence(:severity){|n| n}
  factory :ticket do
    created_by FFaker::Name.name
    description FFaker::Lorem.paragraph
    severity
  end
end
