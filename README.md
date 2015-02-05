# Rack::WithSequel

Rack middleware that explicitely acquires a Sequel database connection for entire request. It's reasonable if you want a Rails-like behaviour where database connection is released by the `ActiveRecord::ConnectionAdapters::ConnectionManagement` middleware at the end of request.

But please use it with **warning** that using `Rack::WithSequel` you'll get **every** request locking one connection from the pool even if database is not used during this request (for example, Rails acquires a connection only when it's needed).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-with_sequel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-with_sequel

## Usage

```ruby
use Rack::WithSequel
```

By default it will wrap every request in `Sequel::Model.db.synchronize do ... end`.

Suppose we have a PostgreSQL connection somewhere:

```ruby
DB = Sequel.connect("postgres://postgres:postgres@localhost:5432/test")
```

Then we can pass it to the middleware as an option:

```ruby
use Rack::WithSequel, db: DB
```

So `DB` will be used instead of `Sequel::Model.db`.

Minimal example:

```ruby
require 'sinatra'
require 'rack/with_sequel'

db = Sequel.connect("postgresql://postgres:postgres@localhost:5432/test")

use Rack::WithSequel, db: db

get '/' do
  puts db[:test].all.inspect
end
```

## Handling connection errors

Sometimes it's reasonable to handle connection errors. In this case it's recommended to define a custom middleware:

```ruby
require 'rack/with_sequel'

class CustomWithSequel < Rack::WithSequel
  ERRORS = [Sequel::DatabaseConnectionError, Sequel::PoolTimeout]

  def call(env)
    super
  rescue *ERRORS
    [503, {}, ["database connection error"]]
  end
end

# ...

use CustomWithSequel
```

## Contributing

1. Fork it ( https://github.com/marshall-lee/rack-with_sequel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
