# FlCountries

This gem provides the canonical list of FutureLearn countries to be used
whenever country data is required. It provides a Country class that contains
finder methods to instantiate country objects.

The list of countries is the ISO-3166 country list with the addition of Kosovo.

If you need to store a country reference in a database, it is best to use the
country code (which is the ISO-3166 alpha2 code) as a reference. This is because
these codes are less likely to change than the name of a country. For example,
if we ever need to translate country names, code that refers to names may
produce inconsistent results.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fl_countries'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fl_countries

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
