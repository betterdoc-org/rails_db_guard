# RailsDbGuard

Prevents connecting to protected environments databases from other environments.

Have you ever used `DATABASE_URL` from production in development? If yes, this is a gem for you. If not, some of your colleague has (or will), so this is a gem for you :)

It is super easy to forget and keep using production database locally and make a disaster. RailsDbGuard is here to protect you!

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rails_db_guard", group: [:development, :test]
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_db_guard

## Usage

Just add `rails_db_guard` to your Gemfile and you are done. You don't need it in production so you can put it to all other groups.  It will raise and error if you try to connect to protected environment database from other environment.

By default `production` is only protected environment so if you have other sensitive environments (staging for example) it would be like:

```ruby
# Gemfile
group :staging, :development, :test do
  gem "rails_db_guard"
end
```

```ruby
# config/application.rb
config.active_record.protected_environments = %w[production staging]
```

## How it works

Rails 5 [added a feature](https://github.com/rails/rails/pull/22967) that prevents destructive actions on production database. New database table `ar_internal_metadata` was added that will store environment name when you run `db:migrate` for the first time.
Now every time you run destructive rake task Rails will raise an exception preventing the data loss. It works by comparing Rails environment with the environment value in the `ar_internal_metadata` table.

But it will do nothing if you run "destructive" action from your app (console, test, ...). This is where RailsDbGuard comes into play. It will add a callback whenever database connection is established and raise an exception preventing you from accessing protected environment from other environments (You can access production database only from production Rails environment).

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Running tests

Testing is a bit specific cause we need to test when database connection is established and that is done for test database during test suite boot. Easiest solution we could think of is to have ActiveRecord models connecting to different databases so we can test what happens when connection is established. This also mean you will need to prepare database for each environment.

    $ cd test/rails_app # to dummy rails app for testing
    $ RAILS_ENV=test bundle exec rake db:migrate
    $ RAILS_ENV=development bundle exec rake db:migrate
    $ RAILS_ENV=production bundle exec rake db:migrate
    $ cd ../.. # to gem root
    $ bundle exec rake test

## ToDo

* MySQL adapter
* CI setup (matrix for multiple database adapter and rails versions combinations)
* Setup Rubocop
* Add option to skip the check if `DISABLE_DATABASE_ENVIRONMENT_CHECK` environment variable is set

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rails_db_guard. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsDbGuard project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rails_db_guard/blob/master/CODE_OF_CONDUCT.md).
