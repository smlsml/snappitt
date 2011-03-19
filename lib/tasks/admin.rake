namespace :admin do

  desc "Free up account by changing username/email"
  task :free_user, :email, :needs => :environment  do |t, args|

    if args[:email]
      User.where(:email => args[:email]).each do |u|
        parts = u.email.split('@')
        new_email = '%s+%s@%s' % [parts[0], u.id, parts[1]]
        new_user  = '%s+%s' % [u.username, u.id]

        puts "Freeing user (%s: %s) by rename to (%s: %s)" % [u.username, u.email, new_user, new_email]

        u.update_attribute(:email, new_email)
        u.update_attribute(:username, new_user)
      end
    end

  end

end