module Blitz
  SEARCH_BATCH = 20
  DEFAULTS = {
    connection: -> { Redis.new },
    namespace: 'default',
    min_length: 3
  }

  class Client
    def initialize(opts)
      @connection = opts[:connection] || DEFAULTS[:connection].call
      @namespace = opts[:namespace] || DEFAULTS[:namespace]
      @min_length = opts[:min_length] || DEFAULTS[:min_length]
    end

    def complete(partial, num = 5)
      unless partial.length >= @min_length
        raise Error, "sample is too short, minimum length is #{@min_length}"
      end

      start = @connection.zrank(key, partial)
      return [] unless start

      words = []
      while words.count < num
        entries = @connection.zrange(key, start, start + SEARCH_BATCH)
        start += SEARCH_BATCH

        whole_words = filter_whole_words(entries)
        matching_words = filter_matching_words(whole_words, partial)

        matching_words.each { |word| words << word[0..-2] }

        break if entries.count < SEARCH_BATCH # hit the end of the list
      end

      words.take(num)
    end

    def clear
      @connection.del(key)
    end

    def load(*words)
      words.each do |word|
        next if word.length < @min_length

        fragments(word).each { |fragment| @connection.zadd(key, 0, fragment) }
      end
    end

    private

    def filter_whole_words(words)
      words.select { |word| word.end_with?('$') }
    end

    def filter_matching_words(words, partial)
      words.select { |word| word.start_with?(partial) }
    end

    def key
      "blitz:#{@namespace}"
    end

    def fragments(word)
      entries = []
      
      entries = ((@min_length - 1)..(word.length - 2)).map { |fragment_length| word[0..fragment_length] }
      entries << "#{word}$"
    end
  end
end
