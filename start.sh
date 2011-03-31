pg_ctl -D ~/psdata stop -m fast
postgres -D ~/psdata &
git pull && bundle install && rake db:migrate && rails s

