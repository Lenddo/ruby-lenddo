# ruby-lenddo

ruby-lenddo allow you to contact Lenddo's REST based services.
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

## White Label Client

*Use Lenddo services while keeping your own branding*

The white label package comes in two service calls made to Lenddo which are meant to allow you to utilize Lenddo services without having the user leave your own ecosystem.

### PartnerToken

**Note**: All token providers must be OAuth 2.0

PartnerToken has the following arguments:

1. **application_id** - this is the client id that you're posting the token for. This must match the application_id you use in the **CommitPartnerJob** step.

2. **provider** - this is the token provider. Valid values are as follows: `Facebook`, `LinkedIn`, `Yahoo`, `WindowsLive`, or `Google`

3. **oauth key** - this is the key returned by oauth for interacting with the token.

    note: The key and secret are not your application key and secret. They're the values which are returned after a user successfully authenticates with the social network's oauth.
oauth secret - optional, leave null if not applicable. Some OAuth providers may return a secret, when this is returned Lenddo will required the secret to use the token.

4. **token data** - This is the raw token as it was received from the provider in Array format. This may include an **extra_data** key.

    Lenddo::WhiteLabelClient.partner_token(application_id, provider, oauth_key, oauth_secret, token_data)

#### Errors

* **BAD_REQUEST** *HTTP Status Code: 400* Request was malformed, or missing required data.

* **INVALID_TOKEN** *HTTP Status Code: 400* Token data was missing required fields or fields had invalid values.

* **TOKEN_FAILURE** *HTTP Status Code: 400* Failure upon attempt to use the token.

* **INTERNAL_ERROR** *HTTP Status Code: 500* An internal error occurred. If this persists please contact a Lenddo Representative.

### CommitPartnerJob

CommitPartnerJob has the following arguments:

1. **partner script id** - Please reference the developer section of the partner dashboard. This will define how you're notified of scoring results.

2. **application id** - This is essentially a one time use transaction id. Once this ID is used it cannot be used again. You can use this value in the `Lenddo::ServiceClient.application_score` to retrieve the score results.

3. **profile ids** - This is an array of ID's composed from the results of the `Lenddo::WhiteLabelClient.partner_token` service call.

4. **verification** - This is an optional argument which will allow you to send probe data with the verification object.

    Lenddo::WhiteLabelClient.commit_partner_job(partnerscript_id, application_id, profile_ids, verification)

#### Errors

* **BAD_REQUEST** *HTTP Status Code: 400* Request was malformed, or missing required data.

* **PARTNER_CLIENT_ALREADY_PROCESSED** *HTTP Status Code 400* This occurs when the specified APPLICATION_ID has already been used.

* **INTERNAL_ERROR** *HTTP Status Code: 500* An internal error occurred. If this persists please contact a Lenddo Representative.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lenddo/ruby-lenddo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).