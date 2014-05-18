require 'test_helper'

class BlitzTest < Minitest::Test
  def test_blitz_init_returns_a_client
    opts = {connection: Object.new, namespace: 'test', min_length: 3}
    client = Blitz.init(opts)
    assert client.instance_of?(Blitz::Client)
  end
end
