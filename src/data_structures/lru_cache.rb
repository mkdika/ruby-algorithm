=begin

LRU (Least Recently Used)
is common algorithm that use to invalidate least hit cache key in one size of caching frame (size).

This implementation will have:
1. O(1) as searching and retrive existing value complexity, using hash.
2. O(1) to rearrange caching frame ordered, using linked list.

=end

class LruCache
  attr_reader :cache_size, :cache_map

  def initialize(cache_size: 3)
    @cache_size = cache_size
    @cache_map = {}
    @front_node = nil
    @rear_node = nil
  end

  def put(value)
    new_node = Node.new(value)
    new_node.child = @front_node

    unless @front_node.nil?
      @front_node.parent = new_node
    end
    @front_node = new_node

    if @rear_node.nil?
      @rear_node = new_node
    end
    @cache_map[value] = new_node
    
    if @cache_map.size > @cache_size
      @cache_map.delete(@rear_node.value)
      @rear_node = @rear_node.parent
      @rear_node.child = nil
    end
  end

  def get(value)
    return nil unless @cache_map.key?(value)

    if @cache_map.size > 1
      node = @cache_map[value]

      if node.value != @front_node.value
        if node.value == @rear_node.value
          @rear_node = @rear_node.parent
          @rear_node.child = nil
        end
        
        node.parent.child = node.child unless node.parent.nil?
        node.child.parent = node.parent unless node.child.nil?
        
        node.parent = nil
        node.child = @front_node
        @front_node.parent = node
        @front_node = node
      end
    end

    return value
  end

  # the most left array is the latest/ least recent
  def cache_nodes_to_array
    arr = []
    node = @rear_node
    begin
      arr << node.value
      node = node.parent
    end while !node.nil?
    return arr
  end

  def cache_map_key_to_array
    @cache_map.keys.to_a
  end

  def cache_size
    @cache_map.size
  end
end

# This is double linked list
class Node
  attr_reader :value, :parent, :child
  attr_writer :parent, :child
  def initialize(value)
    @value = value
    @parent = nil
    @child = nil
  end

  def parent=(node)
    @parent = node
  end

  def child=(node)
    @child = node
  end
end