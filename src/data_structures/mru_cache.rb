=begin

MRU (Most Recently Used)
is common algorithm that use to invalidate the most recently hit cache key in one size of caching frame (size).

MRU is the opposite of LRU.

This implementation will have:
1. O(1) as searching and retrive existing value complexity, using hash.
2. O(1) to rearrange caching frame ordered, using linked list & page_fault variable

=end

class MruCache
  attr_reader :cache_size, :cache_map, :page_fault

  def initialize(cache_size: 3)
    @cache_size = cache_size
    @cache_map = {}
    @page_fault = nil
  end

  def put(value)
    unless @cache_map.key?(value)
      if @cache_map.size >= @cache_size
        @cache_map.delete(@page_fault)
        @cache_map[value] = true
        @page_fault = value
      else
        @cache_map[value] = true
        @page_fault = value
      end
    end
  end

  def get(value)
    return nil unless @cache_map.key?(value)
    if @cache_map.size > 1
      @page_fault = value
    end
    return value
  end

  def cache_map_key_to_array
    @cache_map.keys.to_a
  end

  def cache_size
    @cache_map.size
  end
end
