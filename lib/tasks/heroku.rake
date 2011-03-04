namespace :heroku do

  desc "Deploy code to Heroku"
  task :deploy => :environment do
    Kernel.exec('git push heroku master && bundle exec heroku rake db:migrate')
  end

end