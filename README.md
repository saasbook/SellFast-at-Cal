# SellFast-at-Cal

To run development server locally, follow these steps:

1. You will need to define several environment variable on your local machine:

use 
```
export [KEY]=[VALUE]
```
on your terminal

register for a paypal sandbox app and input the credentials below:
```
PAYPAL_CLIENT_ID 
PAYPAL_CLIENT_SECRET
```

RAILS_ENV set to 'development' on your local dev environment

REDIS_URL for sidekiq (in sidekiq.rb) is defaulted to your local host redis server.

The gmail sender credentials have been hard-coded in the dev environment, a suggested improvement is to have a dev mailing acc and change the corresponding configs in config/environments/development.rb

2. Download postgres and redis server with homebrew
```
brew install postgresql
brew install redis
```

3. start the postgres and redis server with homebrew
```
brew services start postgresql
brew services start redis
```

4. make sure both postgresql and redis are active using this command
```
brew services list
```

5. create a user on postgres
```
/usr/local/opt/postgres/bin/createuser -s postgres
```

6. Run sidekiq worker server
```
bundle exec sidekiq
```

7. set up database
```
rails db:setup
```

8. precompile assets
```
rake assets:precompile
```

9. Then on another terminal, run (you might have to export the env variables again if you run it on another terminal)
```
rails s
```

to start web server



To deploy to heroku,

Have heroku auto-build whatever is on your github repo's master branch, and
You need the following addons
1. Heroku Postgres 
2. Heroku Redis
3. SendGrid

And define the following environment variables on heroku
1. AWS_ACCESS_KEY_ID
2. AWS_BUCKET
3. AWS_REGION
4. AWS_SECRET_ACCESS_KEY
5. DATABASE_URL
6. GMAIL_PASSWORD
7. GMAIL_USERNAME
8. LANG (en_US.UTF-8)
9. PAYPAL_CLIENT_ID
10. PAYPAL_CLIENT_SECRET
11. RACK_ENV
12. RAILS_ENV
13. RAILS_MASTER_KEY
14. REDIS_URL
15. SECRET_KEY_BASE
16. SENDGRID_API_KEY
17. SENDGRID_PASSWORD
18. SENDGRID_USERNAME

Finally, run the following commands on heroku to setup database and assets
```
rails db:setup
```
```
rake assets:precompile
```

You can run these commands on the heroku dashboard console or locally with the command
```
heroku run [COMMAND] -a [APP NAME]
```