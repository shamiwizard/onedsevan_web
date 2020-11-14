# Onedseven web site
It is simple website for our team **onedseven**. Which telling what we do)

Only this dependency for now(this list will be updated)::
- ruby 2.7.2


Testing
===
First you need to create database:
`docker-compose exec/run bundle exec rails db:create`

Run migration:

`docker-compose exec/run bundle exec rails db:migrate`

Run specs

`docker-compose exec/run bundle exec rspec`