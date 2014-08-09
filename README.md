# CrewCheck

CrewCheck helps you utilize github teams to correlate users with roles.

```ruby
OmniAuth::Strategies::CrewCheck.new('github key', 'github secret',
  :role_map => {
    'admin' => ['acme/the-super-users'],
    'moderators' => ['acme/the-regular-joes']
  },
  :role_required => true)
```

You can also use a proc for the `role_map` option:

```ruby
OmniAuth::Strategies::CrewCheck.new('github key', 'github secret',
  role_map ->{{
    'admin' => Team.all.map{|i| 'acme/' + i.github_team_name }
  }})
```

For a user that is part of the 'acme' github organization and is exclusively a github team member of 'the-super-users' OmniAuth will return data like:

```ruby
env['omniauth.auth'] = {
  :provider => 'crew_check',
  # ...
  :extra => {
    :teams => ['acme/the-super-users'],
    :roles => ['admin']
  }
}
```

## Installation

Add this line to your application's Gemfile:

    gem 'crew_check'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crew_check

## Contributing

1. Fork it ( https://github.com/[my-github-username]/crew_check/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
