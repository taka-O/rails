FactoryBot.define do
  factory :course do
    sequence(:name) { |n| "name #{n}" }
    sequence(:description) { |n| "description #{n}" }
    start_at { Time.zone.now.prev_month }
    end_at { Time.zone.now.next_month }
  end
end
