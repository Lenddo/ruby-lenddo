# ruby-lenddo

ruby-lenddo allow you to contact Lenddo's REST based services.

Note: 2.0 is not compatible with 1.X.X version for more info click [here](https://github.com/Lenddo/ruby-lenddo/wiki/Breaking-changes-with-2.0)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lenddo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lenddo

## Configuration

Require the Gem:

    require 'lenddo'
    
Before making API calls you need to configure `@access_key` and `@secret_key`. To do this run the following code:

    Lenddo.configure do |config|
        config.access_key = @access_key
        config.secret_key = @secret_key
    end

Note: To get your `@access_key` and `@secret_key` go to https://dashboard.lenddo.com/client/api_key.

## Service Client

The `ServiceClient` allows the client to send extra information or retrieve the scoring, verification, and decision results from Lenddo.

### Get a Score

To retrieve the score you'll need the application ID and the partner script ID that you used to create the application.

Usage:
   
    require 'lenddo/service_client'
        
    Lenddo::ServiceClient.application_score(@application_id, @partnerscript_id)

### Get Multiple scores

Return an array of LenddoScore records for the supplied application id using models specifically tuned to the applicant pool of the partner associated with the current API user. LenddoScore is a measure of the expected creditworthiness of a Lenddo user. It ranges is from 0 (the highest risk) to 1000 (the lowest risk). Lenddo's scoring algorithms consider over 300 features per user when generating a score. These features are calculated from Lenddo's proprietary social graph as well as from any data specifically shared by the partner. In the event that a score cannot be correctly calculated, the LenddoScore will be returned as -1 along with an array of flag codes.

Usage:
   
    require 'lenddo/service_client'
        
    Lenddo::ServiceClient.application_multiple_scores(@application_id, @partnerscript_id)

### Get a Verification

To retrieve the verification you'll need the application ID and the partner script ID that you used to create the application.

Usage:
    
    require 'lenddo/service_client'
        
    Lenddo::ServiceClient.application_verification(@application_id, @partnerscript_id)
    
### Get an Application Decision

To retrieve the decision you'll need the application ID and the partner script ID that you used to create the application.

Usage:    
       
    require 'lenddo/service_client'
        
    Lenddo::ServiceClient.application_decision(@application_id, @partnerscript_id)

### Get MobileData

If you want to retrieve the mobile data stream from your partner script ID you can use this method.

Usage:
   
    require 'lenddo/service_client'
                
    Lenddo::ServiceClient.mobile_data(@partnerscript_id)
 
    
### Send Extra Application Data

If you're sending extra information with your application you can use this method to submit it. Extra Application Data may be used to enhance the model performance based on data you may already have about a user.

#### Notes

1. You cannot make this request more than once per application/partner script combination. Doing so will result in a BAD_REQUEST response from the service.
2. If you do not know what this functionality is but would like to submit data for Lenddo to work with please contact your Lenddo representative.
3. The Format of the data being sent in the `@extra_data` field should be pre-negotiated with Lenddo and shouldn't deviate from agreement to maximize the use of this call.

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

3. **OAuth key** - this is the key returned by OAuth for interacting with the token.

    Note: The key and secret are not your application key and secret. They're the values which are returned after a user successfully authenticates with the social network's OAuth.
OAuth secret - optional, leave null if not applicable. Some OAuth providers may return a secret when this is returned Lenddo will require the secret to using the token.

4. **token data** - This is the raw token as it was received from the provider in an Hash format. This may include a **extra_data** key.

   Usage:

       require 'lenddo/white_label_client'
        
       application_id = "GENERATED_UNIQUE_ID"
       oauth_key = "USER_ACCESS_TOKEN"
        
       response = Lenddo::WhiteLabelClient.partner_token(@application_id, provider = "Facebook", @oauth_key, oauth_secret = nil, token_data = {})
        
   Response:
        
       puts response.response_code
       => 200
       puts response.status
       => "200 OK"
       puts response.body
       => {"profile_id": "100000000000000FB"}"
    
#### Errors

* **BAD_REQUEST** *HTTP Status Code: 400* Request was malformed, or missing required data.

* **INVALID_TOKEN** *HTTP Status Code: 400* Token data was missing required fields or fields had invalid values.

* **TOKEN_FAILURE** *HTTP Status Code: 400* Failure upon the attempt to use the token.

* **INTERNAL_ERROR** *HTTP Status Code: 500* An internal error occurred. If this persists please contact a Lenddo Representative.

### CommitPartnerJob

CommitPartnerJob has the following arguments:

1. **partner script id** - Please reference the developer section of the partner dashboard. This will define how you're notified of scoring results.

2. **application id** - This is essentially a one-time use transaction id. Once this ID is used it cannot be used again. You can use this value in the `Lenddo::ServiceClient.application_score` to retrieve the score results.

3. **profile ids** - This is an array of ID's composed from the results of the `Lenddo::WhiteLabelClient.partner_token` service call.

4. **verification** - This is an optional argument which will allow you to send probe data with the verification object.
   
   Sample verification object:
   
       verificationData = {
           "name": {
               "first": "John",
               "middle": "J",
               "last": "Doe"
            },
           "date_of_birth": "1990-01-01",
           "employer": "LenddoEFL",
           "phone": { 
               "mobile": "55512456789", 
               "home": "0254897" 
           },
           "employment_period": { 
               "start_date": "2010-05-01", 
               "end_date": "2015-02-30"
           },
           "mothers_maiden_name": {
               "first": "Martha",
               "middle": "K",
               "last": "Smith"
           },
           "government_ids": {[
               "ID1": "555"
           ]},
           "university": "University Name",
           "email": "John@gmail.com",
           "work_email": "John@work.com",
           "address": {
               "latitude" : "40.758896",
               "longitude" : "-73.985130",
               "line_1": "Street 1",
               "line_2": "Street 2",
               "administrative_division" : "Manhattan",
               "city": "New York", 
               "postal_code":"39531",
               "country_code: "USA"
           }
       }   

   Usage:

       require 'lenddo/white_label_client'
        
       partnerscript_id = "YOUR_PARTNERSCRIPT_ID"
       application_id = "GENERATED_UNIQUE_ID"
       profile_ids = ["100000000000000FB"]
        
       response = Lenddo::WhiteLabelClient.commit_partner_job(@partnerscript_id, @application_id, @profile_ids, verification = nil)
       
   Response:
       
       puts response.response_code
       => 200
       puts response.status
       => "200 OK"
       puts response.body
       => {"success": true}

### Errors

* **ACCEPTED** *HTTP Status Code: 202* Strictly speaking, not an error. This status code indicates that not enough data has been gathered to compute the applicant's scores, but data will be available in the future.

* **NOT_FOUND** *HTTP Status Code: 404* The specified application_id was not found

* **BAD_REQUEST** *HTTP Status Code: 400* Request was malformed, or missing required data.

* **PARTNER_CLIENT_ALREADY_PROCESSED** *HTTP Status Code 400* This occurs when the specified APPLICATION_ID has already been used.

* **INTERNAL_ERROR** *HTTP Status Code: 500* An internal error occurred. If this persists please contact your Lenddo Representative.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lenddo/ruby-lenddo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.