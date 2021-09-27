# Proyecto 1

## Requeriments
- Ruby Programming Language
  - https://www.ruby-lang.org/en/downloads/
- MongoDB
  - https://docs.mongodb.com/manual/administration/install-community/

## Install
``` sh
bundle install
```

## Run
---
``` sh
bundle exec ruby http.rb
```
Go to http://localhost:4567

## Routes
- GET `/entries/`
  - Show all the entries on the database
- GET `/entries/:key`
  - Where `:key` is the key name of the entry
  - Show all the entries that has the key name as `:key`
- GET `/entries/id/:id`
  - Where `:id` is the id on the database given by MongoDB
  - Show the entry with id `:id`
- POST `/entries/`
  - Create new entry
  - Need to pass `key` and `value` params
- PATCH `/entries/id/:id`
  - Where `:id` is the id on the database given by MongoDB
  - Update the entry, the key or the value of the entry
- DELETE `/entries/id/:id`
  - Where `:id` is the id on the database given by MongoDB
  - Delete the entry

## Disclaimer
- Based on https://x-team.com/blog/how-to-create-a-ruby-api-with-sinatra/