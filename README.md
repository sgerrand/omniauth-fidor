# OmniAuth Fidor

[![Build Status](https://travis-ci.org/sgerrand/omniauth-fidor.svg?branch=master)](https://travis-ci.org/sgerrand/omniauth-fidor)
[![Code Climate](https://codeclimate.com/github/sgerrand/omniauth-fidor/badges/gpa.svg)](https://codeclimate.com/github/sgerrand/omniauth-fidor)
[![Test Coverage](https://codeclimate.com/github/sgerrand/omniauth-fidor/badges/coverage.svg)](https://codeclimate.com/github/sgerrand/omniauth-fidor/coverage)

This is a OmniAuth strategy for authenticating to [Fidor
Banking][fidor-banking]. To use it, you'll need to sign up for an OAuth2
Application ID and Secret on the [Fidor Developer Page][fidor-developers].

[fidor-banking]: https://www.fidor.de/
[fidor-developers]: https://developer.fidor.de/

## Basic Usage

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-fidor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-fidor

## Usage

```ruby
use OmniAuth::Builder do
  provider :fidor, ENV['FIDOR_KEY'], ENV['FIDOR_SECRET']
end
```

## Development

After checking out the repo, run `rake install:development` to install
dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `rake install`. To release a
new version, update the version number in the `CHANGELOG`, and then run `rake
release`, which will create a git tag for the version, push git commits and
tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

You can also override the API and OAuth URLs used by setting values for the
`FIDOR_API_URL` and/or `FIDOR_OAUTH_URL` environment variables.

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/sgerrand/omniauth-fidor).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
