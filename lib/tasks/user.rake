namespace :user do
  desc "Enriching all users with Clearbit (async)"
  task update_all: :environment do
    users = User.all
    puts "Enqueuing update of #{users.size} users..."
    users.each do |user|
      UpdateUserJob.perform_later(user)
    end
    # rake task will return when all jobs are _enqueued_ (not done).
  end
end

# terminal:
# rails -T | grep user
# We can run it with:
# rails user:update_all

namespace :user do
  desc "Enriching a given user with Clearbit (sync)"
  task :update, [:user_id] => :environment do |t, args|
    user = User.find(args[:user_id])
    puts "Enriching #{user.email}..."
    UpdateUserJob.perform_now(user.id)
    # rake task will return when job is _done_
  end
end

# Update user of id 1 with this command:
# noglob rails user:update[1] || rails user:update\[\1]
