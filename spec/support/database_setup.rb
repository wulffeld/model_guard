ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.string :email
  end
end

class User < ActiveRecord::Base
end

class CreateGuardedUser < User
  include ModelGuard::CreateOrUpdateGuard
end

class UpdateGuardedUser < User
  include ModelGuard::CreateOrUpdateGuard
end

class DestroyGuardedUser < User
  include ModelGuard::DestroyGuard
end
