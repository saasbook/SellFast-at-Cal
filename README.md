# SellFast-at-Cal

To run development server locally, follow these steps:

go to the root of rails app and run command
```
docker-compose build
```
```
docker-compose up
```

The commands above set up the postgres database and sidekiq server

Then on another terminal, run 
```
rails s
```

to start web server
