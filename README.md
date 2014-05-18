## Blitz

**Blitz** is a very simple and lightning fast auto complete engine that makes heavy use
of Redis ordered sets.

### Usage

```ruby
require 'hiredis' # optional
connection = Redis.new
client = Blitz.init(connection: connection, namespace: 'test', min_length: 1)
client.load(*words)
matches = client.complete('part', 3)
```

### Initialization parameters:

* connection: a Redis connection, default is trying to connect to a local instance
* namespace: an identifier in case you want to maintain several lists simultaneously. default is `default`
* min_length: The minimum length partial length to look for. Important when you add words. You might need
to reimport the list of you decide to change the value. default is 3.
