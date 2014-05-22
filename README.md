## Blitz

**Blitz** is a very simple and fast alphabetical auto complete engine
that makes heavy use of Redis ordered sets.

You can add as many words as you want, even millions, without a noticable impact on performance.
As long as you don't run out of space under your Redis instance, Blitz should be lightning fast.

### Usage

```ruby
require 'hiredis' # optional

connection = Redis.new
client = Blitz.init(connection: connection, namespace: 'test', min_length: 1)
client.load(*words)
matches = client.complete(prefix, 3)
```

### Initialization parameters:

* connection: a Redis connection, default is trying to connect to a local instance
* namespace: an identifier in case you want to maintain several lists simultaneously. default is `default`
* min_length: The minimum length length of the prefix to match against. Important when you add words. You might need
to reimport the list if you decide to change the value. default is 3.

### TODO
* Add support for frequency based ordering
