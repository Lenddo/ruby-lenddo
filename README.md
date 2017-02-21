# ruby-lenddo

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/lenddo`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lenddo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lenddo

## Configuration

Require the Gem:

    require 'lenddo'
    
Before make an API calls you need to configure `@access_key` and `@secret_key` in Lenddo. To do this run the following code:

    Lenddo.configure do |config|
        config.access_key = @access_key
        config.secret_key = @secret_key
    end

Note: To get your `@access_key` and `@secret_key` go to https://partners.lenddo.com/api_key.

## Service Client

The `ServiceClient` allows client to send extra information or retrieve the scoring, verification, and decision results from Lenddo. To use run `require 'lenddo/service_client'`

### Get a Score

To retrieve the score you'll need the application ID and the partner script ID that you used to create the application.

    Lenddo::ServiceClient.application_score(@application_id, @partnerscript_id)

### Get a Verification

To retrieve the verification you'll need the application ID and the partner script ID that you used to create the application.

    Lenddo::ServiceClient.application_verification(@application_id, @partnerscript_id)
    
### Get an Application Decision

To retrieve the decision you'll need the application ID and the partner script ID that you used to create the application.

    Lenddo::ServiceClient.application_decision(@application_id, @partnerscript_id)

### Send Extra Application Data

If you're sending extra information with your application you can use this method to submit it. Extra Application Data may be used to enhance the model performance based on data you may already have about a user.

#### Notes

1. You cannot make this request more than once per application/partner script combination. Doing so will result in a BAD_REQUEST response from the service.
2. If you do not know what this functionality is but would like to submit data for Lenddo to work with please contact your Lenddo representative.
3. Format of the data being sent in the `@extra_data` field should be pre-negotiated with Lenddo and shouldn't deviate from agreement to maximize the use of this call.

#### Definitions

* `@application_id` & `@partner_script_id` are the respective ID's you sent the user to the Lenddo service with.
* `@extra_data` is an Array and must contain at least one element

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lenddo/ruby-lenddo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).