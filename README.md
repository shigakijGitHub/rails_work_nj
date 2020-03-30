# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



docker-compose build
でこけたら、以下を実施
```
docker-compose run web bundle update
```

そのあと、
docker-compose up -d
docker-compose run web bundle exec rails db:create


コンテナに入ってからmysqlに入るには、/app配下で
```
mysql -u root -ppassword -h db
```