namespace :heroku do

  desc "Deploy code to Heroku"
  task :deploy => :environment do
    Kernal.exec('git push heroku master')
    Kernal.exec('bundle exec heroku rake db:migrate')
  end

end