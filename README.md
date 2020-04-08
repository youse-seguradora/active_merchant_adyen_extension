# ActiveMerchantAdyenExtension

This library is meant to be an extension to `AdyenGateway` implemented by `ActiveMerchant`.

Right now, it only implements the `secure_store` method, which is responsible for sending the encrypted credit card data to Adyen, so they can tokenize this credit card.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_merchant_adyen_extension'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_merchant_adyen_extension

Set the environment variable `ADYEN_LIVE_URL_PREFIX` with your **adyen live endpoint url prefix**.

## Usage

For instructions about how to use it, please read the **Usage** section [ActiveMerchant](https://github.com/activemerchant/active_merchant#usage) and more specific about the Adyen [here](https://github.com/activemerchant/active_merchant/blob/master/lib/active_merchant/billing/gateways/adyen.rb).

### Notes:

In `development` and `test` environment it's very important to define
ActiveMerchant environment you will be using to test your app like so:

```ruby
#config/environments/{environment.rb}
App::Application.configure do
  config.setting...
end
ActiveMerchant::Billing::Base.mode = :test
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/youse-seguradora/active_merchant_adyen_extension. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/youse-seguradora/active_merchant_adyen_extension/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveMerchantAdyenExtension project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/youse-seguradora/active_merchant_adyen_extension/blob/master/CODE_OF_CONDUCT.md).
