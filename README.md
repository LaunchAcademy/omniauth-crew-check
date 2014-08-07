# CrewCheck

```ruby
CrewCheck.configure do |c|
  c.role_map = {
    'admins' => ['org name/the-super-users'],
    'moderators' => ['org name/the-regular-joes']
  }

  # OR
  c.role_map ->{{
    'admins' => Team.all.map{|i| 'org name/' + i.github_team_name }
  }}

  c.authorize_non_members = true
  c.require_authorized_team = true
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'crew_check'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crew_check

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/crew_check/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
