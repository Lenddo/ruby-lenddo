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
    
Before make an API calls you need to configure @access_key and @secret_key in Lenddo. To do this run the following code:

    Lenddo.configure do |config|
        config.access_key = @access_key
        config.secret_key = @secret_key
    end

Note: To get your @access_key and @secret_key contact Lenddo or go to https://partners.lenddo.com/api_key.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lenddo/ruby-lenddo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).