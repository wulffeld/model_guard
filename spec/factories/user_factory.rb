FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end

  factory :create_guarded_user, parent: :user, class: "CreateGuardedUser"
  factory :update_guarded_user, parent: :user, class: "UpdateGuardedUser"
  factory :destroy_guarded_user, parent: :user, class: "DestroyGuardedUser"
end
