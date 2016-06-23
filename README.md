[Formstack v2 API Documentation]

# Formstack Ruby Gem

This is a Ruby client to v2 of the Formstack API. It has a low level
call-for-call functional style API and a higher level object style API.
Let's see some examples!

```ruby
# Fetch all forms at once
forms = Formstack::Form.all

# Fetch a single form by ID
form = Formstack::Form.find(123)

# Get collections for items on a form
form.fields
form.submissions
form.confirmation_emails
form.notification_emails
form.submissions

# Create a new item from the collection
form.fields.create(type: "string", label: "New Field") # => <Field...>
form.submissions.create => <Submission...>

# Update a form
form.update(active: false)

# Copy a form
form.copy # => Returns the newly copied form

# Reload a form (useful to convert a list version of an object to a show
# version--the API returns different object structures for each endpoint)
form.load

# Delete a form
form.delete
```

Each of the individual objects (fields, submissions, etc.) can be
loaded, updated, or deleted just like a form. There is also a `create`
class method on each of the underlying classes if you would rather say
`Formstack::Field.create(form_id, field_attributes)`.

There is also a `Client` class that defines each endpoint as a seperate
method. It is the low-level API that the above API uses. You can use it
as follows:

```ruby
client = Formstack::Client.new
client.forms
client.form(form_id)
client.create_form(form_attributes)
client.update_form(form_id, form_attributes)
client.delete_form(form_id)
client.copy_form(form_id)

client.fields(form_id)
#...
```

To see a full list of methods check out the [Client class].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'formstack_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install formstack_client

## Setup

In order to get rolling, follow the installation instructions above and
then set the `FORMSTACK_ACCESS_TOKEN` environment variable to a valid
access token for your account. You're good to go!

If you don't know your access token you can create a new one for your
account on the [Formstack API Applications] page.


## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `rake pry`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/watermarkchurch/formstack.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[Formstack v2 API Documentation]: https://developers.formstack.com/v2.0
[Formstack API Applications]: https://www.formstack.com/admin/apiKey/main
[Client class]: https://github.com/watermarkchurch/formstack/blob/master/lib/formstack/client.rb
