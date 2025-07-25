FactoryBot.define do
  factory :user do
    pid { Faker::Internet.uuid }
    email { Faker::Internet.unique.email }
    password_digest { BCrypt::Password.create('password') }
    name { Faker::Name.name }
    role { :admin }
  end
end
