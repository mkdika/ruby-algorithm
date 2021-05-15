=begin

LRU (Least Recently Used)
is common algorithm that use to invalidate least hit cache key in one size of caching frame (size).

This implementation will have:
1. O(1) as searching and retrive existing value complexity, using hash.
2. O(1) to rearrange caching frame ordered, using linked list.

=end

class LruCache
  attr_reader :cache_size, :cache_map, :cache_nodes

  def initialize(cache_size: 5)
    @cache_size = cache_size
    @cache_map = {}
    @cache_nodes = nil
  end

  def put(key, value)

    @cache_map[key] = value

    if @cache_nodes.nil?
      @cache_nodes = LruNode.new(key, nil, nil) 
      @first_node = @cache_nodes
    else
      if @cache_map.size <= @cache_size
        new_node = LruNode.new(key, nil, @cache_nodes)
        @cache_nodes.parent = new_node
        @cache_nodes = new_node

        if @first_node.parent.nil?
          @first_node.parent = new_node
        end
      else
        @cache_map.delete @first_node.key
        new_first_node = @first_node.parent
        new_first_node.child = nil
        @first_node = new_first_node
        new_node = LruNode.new(key, nil, @cache_nodes)
        @cache_nodes.parent = new_node
        @cache_nodes = new_node
      end
    end

  end

  def get(key)
    if @cache_map.key? key
      


      @cache_map[key]
    else
      nil
    end
  end

  # the most left array is the latest/ least recent
  def cache_nodes_to_array
    arr = []
    node = @first_node
    begin
      arr << node.key
      node = node.parent
    end while !node.nil?
    return arr
  end

  def cache_map_key_to_array
    @cache_map.keys.map {|k| k}
  end

  def cache_size
    @cache_map.size
  end
end

class LruNode
  attr_reader :key, :parent, :child
  attr_writer :parent, :child
  def initialize(key, parent, child)
    @key = key
    @parent = parent
    @child = child
  end

  def parent=(value)
    @parent = value
  end

  def child=(value)
    @child = value
  end
end