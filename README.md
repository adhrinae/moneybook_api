# MoneyBook API Server

This is a sample in order to provide an example of a JSON API server built with [Hanami Framework](http://hanamirb.org) using JWT based authentication.

There is a tutorial for implementation of this project. [Please Visit here(Korean)](https://emaren84.github.io/blog/archivers/hanami-vuejs-moneybook-api-server)

Main features:

- Implement a token based authentication using [JWT Gem](https://github.com/jwt/ruby-jwt)
- Store encrypted password in the database with [BCrypt](https://github.com/codahale/bcrypt-ruby)
- Return a JSON representation of resources

Development environment

- Ruby v2.4.1
- Hanami v1.0.0
- Postgresql v9.6.2



## Getting started

### Before the beginning

You need at least Ruby v2.3+, and `bundler`. If you have not installed Hanami, Please install it with this command first.

	gem install hanami
You need postgresql installed as well, or change `Gemfile` in order to use SQLite3 instead.

```ruby
# Gemfile
# ...
gem 'pg' # => gem 'sqlite3'
# ...
```



### Clone the repo


```
git clone git@github.com:emaren84/moneybook_api.git
cd moneybook_api
bundle install
```

then you should create `.env.*` files for development and test environment. and set `DATABASE_URL`, `JWT_ISSUER`, `JWT_SECRET`.

```
# .env.development / .env.test
DATABASE_URL="postgresql://username:password@localhost/moneybook_api_development" # or moneybook_api_test
JWT_ISSUER="localhost" # or Your domain name
JWT_SECRET="your secret" # Strongly recommend SHA-256 encrypted hash
```

`DATABASE_URL` have to be changed that if you want to use SQLite3 as a databse engine.

```
DATABASE_URL="sqlite://db/moneybook_api_development"
```



### Prepare databases

```
bundle exec hanami db prepare
bundle exec hanami db migrate
HANAMI_ENV=test bundle exec hanami db prepare
HANAMI_ENV=test bundle exec hanami db migrate
```



### Test the app

```
bundle exec rake test
```

Tests aren't elegant nor covering whole application yet. It needs to be improved.



### Start the server

```
bundle exec hanami server
```

By deafult Hanami development server is launched at `http://localhost:2300`

