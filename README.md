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

7. precompile assets
```
rake assets:precompile
```

8. Then on another terminal, run (you might have to export the env variables again if you run it on another terminal)
```
rails s
```

to start web server
