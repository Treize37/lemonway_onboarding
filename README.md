# LemonwayOnboarding

This gem provides access points to the new Lemonway onboarding API, making it easier to integrate and use the features offered by the Lemonway platform in your Ruby applications.

## Installation

Install the gem and add to the application's Gemfile by executing:

    bundle add lemonway_onboarding

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install lemonway_onboarding

## Usage

To use the LemonwayOnboarding gem, first require it in your Ruby application:

```ruby
require 'lemonway_onboarding'
```

### Configuration

You can configure the gem globally, or pass a configuration to the client:

```ruby
config = LemonwayOnboarding::Configuration.new do |c|
  c.token = 'your_api_token'
  c.environment = 'sandbox' # or 'production'
  # c.proxy = 'http://proxy.example.com:8080' # Optional
  # c.logger = Logger.new('lemonway.log')     # Optional
end
```

### Creating a Client

Initialize a client with your Lemonway API credentials:

```ruby
client = LemonwayOnboarding::Client.new(config)
```

### Using the API

#### Accounts

```ruby
accounts_api = LemonwayOnboarding::Api::Accounts.new(client)
# Create a business account
response = accounts_api.create('business', { name: 'My Company' })
# List accounts
accounts = accounts_api.index(status: 'active')
# Show a specific account
account = accounts_api.show(123)
```

#### Onboardings

```ruby
onboardings_api = LemonwayOnboarding::Api::Onboardings.new(client)
# Create an onboarding
response = onboardings_api.create('individual', { first_name: 'John', last_name: 'Doe' })
# Resume an onboarding
resume = onboardings_api.update(456)
```

#### Documents

```ruby
documents_api = LemonwayOnboarding::Api::Documents.new(client)
# Get a document for an account
doc = documents_api.get(789, 'identity')
# Update a document for an onboarding
updated = documents_api.update(321, { file: '...' })
```

### Error Handling

All API calls will raise an exception if the request fails or times out. You can handle errors as follows:

```ruby
begin
  response = accounts_api.create('business', { name: 'My Company' })
  puts response
rescue => e
  puts "Error: #{e.message}"
end
```

### Logging

You can provide your own logger via the configuration. By default, logs are output to STDOUT.

---

For more advanced usage and available methods, please refer to the [API documentation](https://docs.lemonway.com/).

## Development

### Prerequisites

1. [Install RVM](https://rvm.io/)
2. Install Ruby with `rvm install` and create alias with `rvm alias create default`

### Running

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/Treize37/lemonway_onboarding>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Treize37/lemonway_onboarding/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LemonwayOnboarding project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Treize37/lemonway_onboarding/blob/main/CODE_OF_CONDUCT.md).
