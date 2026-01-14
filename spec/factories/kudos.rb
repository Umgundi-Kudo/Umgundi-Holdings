FactoryBot.define do
  factory :kudo do
    association :sender, factory: :user
    association :receiver, factory: :user

    category { "Gratitude" }
    message  { "Great work!" }
  end
end
