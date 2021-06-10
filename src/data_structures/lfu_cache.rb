=begin

LFU (Least Frequently Used)
is common algorithm that use to invalidate least frequently/common used hit cache key

This implementation will have:
1. O(1) as searching and retrive existing value complexity, using hash.
2. O(1) to rearrange caching frame ordered, using linked list.

=end

class LfuCache
  attr_reader :cache_size, :cache_map, :cache_counter

  def initialize(cache_size: 3)
    @cache_size = cache_size
    @cache_map = {}
    @cache_counter = {1 => []}
  end

  def put(value)
    unless @cache_map.key?(value)
      if @cache_map.size >= @cache_size

        c = 1
        while @cache_counter[c].nil? || @cache_counter[c] == [] 
          c += 1
        end
        n = @cache_counter[c].shift
        @cache_map.delete(n) 
      end
      @cache_map[value] = 1
      @cache_counter[1] << value
    end
  end

  def get(value)
    return nil unless @cache_map.key?(value)

    counter = @cache_map[value]
    @cache_counter[counter].delete(value)
    counter += 1
    if @cache_counter.key?(counter)
      @cache_counter[counter] << value
    else
      @cache_counter[counter] = [value]
    end
    @cache_map[value] = counter

    return value
  end

  def cache_map_key_to_array
    @cache_map.keys.to_a
  end
end


# This is double linked list
# class Node
#   attr_reader :value, :parent, :child
#   attr_writer :parent, :child
#   def initialize(value)
#     @value = value
#     @parent = nil
#     @child = nil
#   end

#   def parent=(node)
#     @parent = node
#   end

#   def child=(node)
#     @child = node
#   end
# end