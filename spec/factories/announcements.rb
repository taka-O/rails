FactoryBot.define do
  factory :announcement do
    sequence(:title) { |n| "title #{n}" }
    sequence(:content) { |n| "content #{n}" }
    category { :all_user }
    start_at { Time.zone.now.prev_month }
    end_at { Time.zone.now.next_month }
  end
end
