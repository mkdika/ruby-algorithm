=begin

Simple Graph abstraction

- Using integer as vertex type & vertices key

=end

class UndirectGraph

  def initialize
    @vertices = {}
  end

  def get_vertices
    return deep_copy(@vertices)
  end

  def add_vertex(value)
    validate_integer(value)

    unless @vertices[value]
      @vertices[value] = []
    end
  end

  def add_edge(source_vertex, destination_vertex)
    validate_integer(source_vertex, destination_vertex)

    unless @vertices[source_vertex]
      add_vertex(source_vertex)
    end

    unless @vertices[destination_vertex]
      add_vertex(destination_vertex)
    end

    @vertices[source_vertex] << destination_vertex
    @vertices[destination_vertex] << source_vertex
  end

  def remove_vertex(value)
    validate_integer(value)

    @vertices.delete(value)
    @vertices.each do |k,v|
      v&.delete(value)
    end
  end

  def remove_edge(source_vertex, destination_vertex)
    validate_integer(source_vertex, destination_vertex)

    @vertices[source_vertex]&.delete(destination_vertex)
    @vertices[destination_vertex]&.delete(source_vertex)
  end

  def vertex_exist?(value)
    validate_integer(value)
    return @vertices.key? value
  end

  # Use DFS (recursive stack)
  def find_connected_vertices_to(value)
    validate_integer(value)
    return nil if @vertices[value].nil?

    result = []
    cache = {value => true}

    return connected_vertices(value, result, cache) 
  end

  # Use DFS (recursive stack)
  def find_any_path_between_vertices(source_vertex, destination_vertex)
    validate_integer(source_vertex, destination_vertex)
    return nil if @vertices[source_vertex].nil? || @vertices[destination_vertex].nil?
    return path_between_vertices(source_vertex, destination_vertex)
  end

  private

  def path_between_vertices(source, destination)
    result = []
    @vertices[source].each do |n|
      if n == destination
        result << [source, n]
      else
        traverse_path([source, n], result, n, destination)
      end
    end
    return result
  end

  def traverse_path(tmp_result, result, target, destination)
    found = false
    @vertices[target].each do |n|
      unless tmp_result.include?(n)
        new_arr = tmp_result + [n]
        if n == destination
          tmp_result = new_arr
          found = true
          break
        else
          traverse_path(new_arr, result, n, destination)
        end
      end
    end
    result << tmp_result if found
  end

  def connected_vertices(n, result, cache)
    @vertices[n].each do |i|
      unless cache.key?(i)
        cache[i] = true
        result << i
        connected_vertices(i, result, cache) 
      end
    end
    return result
  end

  def validate_integer(*values)
    values.each do |v|
      raise ArgumentError, 'not an integer' unless v.is_a? Integer
    end
  end

  def deep_copy(object)
    return Marshal.load(Marshal.dump(object))
  end
end