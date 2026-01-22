# faker-omniauth

An example directory of how to use `Faker::Base` class to create external generators.

This gem adds a new provider to the `Faker::Omniauth` generator.

## Installation

This gem hasn't been published yet. To use it locally:

```sh
gem build faker-omniauth.gemspec
gem install ./faker-omniauth-0.0.0.gem
```

## Usage

```ruby
require 'faker-omniauth'

Faker::Omniauth.microsoft => { provider: 'entra_id', ...}
```

