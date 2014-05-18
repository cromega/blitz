require 'test_helper'

class Blitz::ClientTest < MiniTest::Test
  WORDS = %w(word1 badword word3 word2 word4)

  def setup
    @client = Blitz.init(
      connection: Redis.new,
      namespace: 'test',
      min_length: 3
    )

    @client.clear
    @client.load(*WORDS)
  end

  def test_complete_returns_the_right_words
    matches = @client.complete('wor', 3)
    assert_equal matches, %w(word1 word2 word3)
  end

  def test_clear_clears_autocomplete_list
    @client.clear
    matches = @client.complete('wor', 3)
    assert_equal matches, []
  end

  def test_load_loads_all_the_fragments
    conn = @client.instance_variable_get(:@connection)
    fragments = conn.zrange('blitz:test', 0, -1)
    assert_equal fragments.size, 11
  end
end
